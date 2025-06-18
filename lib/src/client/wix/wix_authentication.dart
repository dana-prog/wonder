import 'dart:async';
import 'dart:convert';

import 'package:app_links/app_links.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pkce/pkce.dart';
import 'package:uuid/uuid.dart';

import '../../logger.dart';
import '../authentication.dart';
import '../token.dart';
import 'wix_api_service.dart';

class WixAuthentication extends Authentication {
  // String get _siteId => 'd03a309f-520f-4b7e-9162-dbb99244ceb7';

  // String get _apiKeyAuth =>
  //     'IST.eyJraWQiOiJQb3pIX2FDMiIsImFsZyI6IlJTMjU2In0.eyJkYXRhIjoie1wiaWRcIjpcIjEyZjhlMWQ1LTRmOWQtNDM0Ni1hNzk4LTA2ZGE1MjFhMzRmNVwiLFwiaWRlbnRpdHlcIjp7XCJ0eXBlXCI6XCJhcHBsaWNhd*GlvblwiLFwiaWRcIjpcIjk2NDlhYWM2LTgwMzAtNDlmMy1iMmYzLTBjNTFiYTk5ZTY3MlwifSxcInRlbmFudFwiOntcInR5cGVcIjpcImFjY291bnRcIixcImlkXCI6XCIxMjQ2ZmU0ZC1jMmU0LTQwNmItOWNiOS1iMmZlZGJmNTJjM2RcIn19IiwiaWF0IjoxNzQ3NDE5NDI1fQ.fxH6Kq8Udf9N_2eXS0l0Zd9ahNldSxleA8KHwCpOSo-yhMiD2pdJN4d3sVVED-vY_r8OF9Z7QzslNv8OSLuRvdadEPkdP6xatVCQ4U72TOnK-NAzStftyBJ5TsDCJRL-wsKqQ8Q29ZTgWMCBBLnmAJS0pGLZ6QLcaA1DWRK6SwhpKf3TBjqY7QmUG0TtdUQsfiaKxlZn0U2EjFz5A-yDQZ4UaV9k5Rb8LTaZTyJxxymPhOJVYeZdQ5ej3U6mwSuxhPpS7S6G6XN77CLsTU7iODb5PPrIkSF3nllZ4H2x_Q4FL5IIjDnqvkjit8hMi-fQBjP8uMIQR5MsoYn3Q9Zx_Q';
  static const _tokenStorageKey = 'token';
  static final String _state = Uuid().v4();

  final String authRedirectUrl;
  Token? _token;

  final _storage = const FlutterSecureStorage();

  WixAuthentication._(this.authRedirectUrl);

  Future<void> _init({Token? token}) async {
    if (token != null) {
      logger.t('[WixAuthentication._init] setting token: ${token.toJson()}');
      await _setToken(token);
      return;
    }

    final tokenString = await _storage.read(key: _tokenStorageKey);
    if (tokenString != null) {
      try {
        final token = jsonDecode(tokenString);
        _token = Token(
          grantType: GrantType.values.byName(token['grantType']),
          accessToken: token['accessToken'],
          refreshToken: token['refreshToken'],
          expiresAt: DateTime.parse(token['expiresAt']),
        );
        logger.t(
          '[WixAuthentication._init] ${_token == null ? 'No tokens found in storage' : 'loaded tokens from storage: ${jsonEncode(_token!.toJson())}'}',
        );
      } catch (e) {
        logger.w('[WixAuthentication._init] Failed to parse token from storage');
        _token = null;
      }
    }
  }

  static Future<WixAuthentication> create({required String authRedirectUrl, Token? token}) async {
    final instance = WixAuthentication._(authRedirectUrl);
    await instance._init(token: token);
    return instance;
  }

  @override
  Future<void> login() async {
    logger.d('[WixAuthentication.login]');

    if (_token?.isValid == false) {
      await renewToken();
    }

    if (_token?.grantType == GrantType.member) {
      logger.t('[WixAuthentication._loginAsMember] already logged in as member');
      return;
    }

    if (_token == null) {
      await loginAsAnonymous();
    }

    final pkcePair = PkcePair.generate();
    final loginUrl = await FetchLoginUrlEndpoint(
      accessToken: _token!.accessToken,
      redirectUri: authRedirectUrl,
      codeChallenge: pkcePair.codeChallenge,
      state: _state,
    ).call();
    logger.t('[WixAuthentication.login] redirecting to loginUrl: $loginUrl');
    final code = await _navigateToLoginUrl(loginUrl);
    if (code == null) {
      logger.d('no code received from loginUrl, abort login');
      return;
    }

    logger.t('[WixAuthentication.login] code received from loginUrl: $code');
    final token = await GenerateMemberTokenEndpoint(
            code: code, codeVerifier: pkcePair.codeVerifier, redirectUri: authRedirectUrl)
        .call();
    await _setToken(token);
    logger.t('[WixAuthentication.login] token was set: $token');
  }

  @override
  Future<void> logout() async {
    logger.d('[WixAuthentication.logout]');
    // final url = await FetchLogoutUrlEndpoint(accessToken: _token!.accessToken).call();
    // _openLogoutUrl(url);
    await _setToken(null);
  }

  @override
  Token? get token => _token;

  @override
  Future<dynamic> getMyMember() async {
    final http.Response response = await http.get(
      Uri.parse('https://www.wixapis.com/members/v1/members/my'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token?.accessToken}',
      },
    );

    return jsonDecode(response.body)['member'];
  }

  Future<void> loginAsAnonymous() async {
    logger.t('[WixAuthentication._loginAsAnonymous]');
    final anonymousToken = await GenerateAnonymousTokenEndpoint().call();
    logger.t('[WixAuthentication._loginAsAnonymous] anonymous token generated: $anonymousToken');
    await _setToken(anonymousToken);
  }

  Future<void> _setToken(Token? token) async {
    logger.d(
      token != null
          ? '[WixAuthentication._setToken] setting ${token.grantType} token'
          : '[WixAuthentication._setToken] clearing token',
    );
    _token = token;

    if (_token == null) {
      await _storage.delete(key: _tokenStorageKey);
      return;
    }

    await _storage.write(
      key: _tokenStorageKey,
      value: _token == null
          ? 'null'
          : jsonEncode({
              'grantType': _token!.grantType.name,
              'accessToken': _token!.accessToken,
              'refreshToken': _token!.refreshToken,
              'expiresAt': _token!.expiresAt.toIso8601String(),
            }),
    );
  }

  Future<Uri?> _openUrl(String url) async {
    logger.t('[WixAuthentication._openUrl] loginUrl: $url');

    final authCompleter = Completer<Uri?>();
    final appLinks = AppLinks();
    late final StreamSubscription<Uri> sub;

    sub = appLinks.uriLinkStream.listen(
      (redirectUri) {
        logger.i('[WixAuthentication._openUrl] listener called with uri: $redirectUri');
        if (authRedirectUrl.startsWith(redirectUri.scheme) == true) {
          sub.cancel();
          authCompleter.complete(redirectUri);
        }
      },
      onError: (e) {
        logger.i(
          '[WixAuthentication._redirectToLoginUrl] (uriLinkStream) User did not authenticate on login redirect',
          error: e,
        );
        sub.cancel();
        authCompleter.complete(null);
      },
    );

    try {
      await launchUrl(
        Uri.parse(url),
        customTabsOptions: CustomTabsOptions(
          urlBarHidingEnabled: true,
          showTitle: true,
          // colorSchemes: CustomTabsColorSchemes.defaults(
          //   toolbarColor: Theme.of(context).colorScheme.surface,
          // ),
        ),
        // safariVCOptions: SafariViewControllerOptions(
        //   preferredBarTintColor: Theme.of(context).colorScheme.surface,
        //   preferredControlTintColor: Theme.of(context).colorScheme.onSurface,
        //   dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        // ),
      );
      logger.d('[WixAuthentication._redirect] launched url: $url');
    } catch (e) {
      logger.i('[WixAuthentication._redirect] failed to launch url: $url', error: e);
      return null;
    }

    final resUri = await authCompleter.future;
    logger.d('[WixAuthentication._redirect] result: $resUri');
    return resUri;
  }

  Future<String?> _navigateToLoginUrl(String url) async {
    logger.t('[WixAuthentication._redirectToLoginUrl] loginUrl: $url');
    final uri = await _openUrl(url);
    if (uri == null) {
      return null;
    }

    final params = Uri.splitQueryString(uri.fragment);
    final stateParam = params['state'];
    final codeParam = params['code'];

    logger.t(
      '[WixAuthentication._redirectToLoginUrl] uri: $uri, params: $params, responseState: $stateParam, authCode: $codeParam',
    );

    if (stateParam == null) {
      throw Exception(
        '[WixAuthentication._redirectToLoginUrl] No state returned from redirect URI',
      );
    }
    if (stateParam != _state) {
      throw Exception(
        '[WixAuthentication._redirectToLoginUrl] State mismatch: expected $_state, got $stateParam',
      );
    }
    if (codeParam == null) {
      throw Exception(
        '[WixAuthentication._redirectToLoginUrl] No authentication code returned from redirect URI',
      );
    }

    return codeParam;
  }

  // Future<void> _openLogoutUrl(String url) async {
  //   logger.t('[WixAuthentication._openLogoutUrl] logoutUrl: $url');
  //   final uri = await _openUrl(url);
  //   logger.d('[WixAuthentication._openLogoutUrl] _redirect returned uri: $uri');
  //   // final uri = Uri.parse(logoutUrl);
  //   // if (await canLaunchUrl(uri)) {
  //   //   // TODO: try other launch modes
  //   //   launchUrl(uri, mode: LaunchMode.externalApplication);
  //   // }
  // }

  Future<void> renewToken() async {
    logger.t('[WixAuthentication._renewToken] renewing token: $_token');
    assert(_token != null, 'Token must not be null to renew it');
    assert(_token?.isValid == true, 'Token must be expired to renew it');

    final renewedToken = await RenewTokenEndpoint(token: _token!).call();
    await _setToken(renewedToken);
  }
}

// TODO: check whether we can use the following class for logout (so that we will use wix logout url but will not open a new browser which does not redirect back to our app)
// Here’s a complete, minimal LogoutWebView widget that:
//
// Opens your hosted logout-redirect page
//
// Intercepts myapp://callback?logout=1
//
// Pops the screen or runs your callback
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class LogoutWebView extends StatefulWidget {
//   final String logoutRedirectUrl;
//   final void Function()? onLogoutComplete;
//
//   const LogoutWebView({
//     required this.logoutRedirectUrl,
//     this.onLogoutComplete,
//     super.key,
//   });
//
//   @override
//   State<LogoutWebView> createState() => _LogoutWebViewState();
// }
//
// class _LogoutWebViewState extends State<LogoutWebView> {
//   late final WebViewController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onNavigationRequest: (request) {
//             final url = request.url;
//             if (url.startsWith('myapp://callback')) {
//               final uri = Uri.parse(url);
//               if (uri.queryParameters['logout'] == '1') {
//                 widget.onLogoutComplete?.call();
//                 Navigator.of(context).pop();
//               }
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(widget.logoutRedirectUrl));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Logging out...')),
//       body: WebViewWidget(controller: _controller),
//     );
//   }
// }

// usage:
// Navigator.of(context).push(
// MaterialPageRoute(
// builder: (_) => LogoutWebView(
// logoutRedirectUrl: 'https://www.koh-phangan-wonder.com/logout-redirect',
// onLogoutComplete: () {
// // clear local session, navigate to login screen, etc.
// },
// ),
// ),
// );

// TODO: check whether we can change the login flow so that we will perform the redirect on our own (and the user will not have to click the navigate back to app button)
// Use a Verified HTTPS Redirect Page
// You cannot reliably auto-redirect from the Wix login URL to myapp://callback directly because:
//
// Mobile browsers block automatic custom scheme redirects
//
// Android (especially Chrome) will always show a prompt
//
// So you insert a trusted HTTPS redirect page in the middle that does the redirect via JavaScript.
//
// 🧩 Step-by-Step: Seamless Auto-Return After Login
// 1. Create a redirect HTML page
// Create a page on your Wix site (or GitHub Pages, Netlify, etc.):
//
// https://www.koh-phangan-wonder.com/login-redirect
//
// Add this content:
//
// html
// Copy
// Edit
// <!DOCTYPE html>
// <html>
// <head>
// <meta charset="UTF-8">
// <title>Logging you in...</title>
// <script>
// const params = new URLSearchParams(window.location.search);
// const code = params.get("code");
// const state = params.get("state");
//
// if (code) {
// const redirectUri = `myapp://callback?code=${encodeURIComponent(code)}&state=${encodeURIComponent(state || "")}`;
// window.location.href = redirectUri;
// }
// </script>
// </head>
// <body>
// <p>Logging you in...</p>
// </body>
// </html>
// This script reads the code returned by Wix and redirects to your app with it.
//
// 2. Set this as your redirectUri when requesting the login URL
// In your Wix auth setup:
//
// json
// Copy
// Edit
// POST https://www.wixapis.com/oauth2/authorization-url
//     {
// "clientId": "...",
// "provider": "google",
// "redirectUri": "https://www.koh-phangan-wonder.com/login-redirect"
// }
// Wix will redirect the user to your login-redirect page after login, and the script will silently open myapp://callback?... — bypassing the "open this app?" popup on many browsers.
//
// 3. Handle the deep link in your app
// Use app_links to listen for:
//
// dart
// Copy
// Edit
// AppLinks().uriLinkStream.listen((uri) {
// final code = uri.queryParameters['code'];
// if (code != null) {
// // exchange code for token
// }
// });
// ✅ Bonus (optional fallback):
// If the browser still shows a prompt on some devices, add a message on the redirect page like:
//
// "Redirecting you back to the app. If nothing happens, tap here."
// And make it a fallback link:
//
// html
// Copy
// Edit
// <a href="myapp://callback?code=XYZ">Tap to return to app</a>
