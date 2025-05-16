import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'package:pkce/pkce.dart';

import '../../logger.dart';
import 'token.dart';

enum LoginState {
  loggedInAsVisitor,
  loggedInAsMember,
  visitorLoginExpired,
  memberLoginExpired,
  loggedOut,
}

class WixAuthentication {
  static const _clientId = '3e1cec28-b221-4170-b689-0d0cbb2f19c8';
  static const _redirectUri = 'myapp://callback';
  static const _scope = 'offline_access openid email profile';
  static const _tokenStorageKey = 'token';

  final Completer<void> _loadingTokens = Completer<void>();
  Token? _token;

  final _storage = const FlutterSecureStorage();

  WixAuthentication() {
    logger.t('[WixAuthentication.constructor]');
    _loadTokenFromStorage();
  }

  // Future<void> login(GrantType grantType) async {
  //   await _loadingTokens.future;
  //
  //   logger.d('[WixAuthentication.login] start');
  //   final pkcePair = PkcePair.generate();
  //
  //   // final appTokens = await _loginAsVisitor();
  //   final body = await _fetchToken({
  //     'grantType': 'anonymous',
  //     'clientId': _clientId,
  //   });
  //   final token = Token.fromBody(GrantType.anonymous, body);
  //   logger.d('[WixAuthentication.login] appAccessTokens: $token');
  //
  //   // final loginUrl = await _getManagedLoginUrl(token.accessToken, pkcePair.codeChallenge);
  //   final response = await http.post(
  //     Uri.parse('https://www.wixapis.com/redirect-session/v1/redirect-session'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ${token.accessToken}',
  //     },
  //     body: jsonEncode({
  //       'auth': {
  //         'authRequest': {
  //           'clientId': _clientId,
  //           'redirectUri': _redirectUri,
  //           'codeChallenge': pkcePair.codeChallenge,
  //           'codeChallengeMethod': 'S256',
  //           'responseType': 'code',
  //           'responseMode': 'query',
  //           'scope': _scope,
  //           'state': PkcePair.generate().codeChallenge,
  //         }
  //       }
  //     }),
  //   );
  //   final String loginUrl = jsonDecode(response.body)['redirectSession']['fullUrl'];
  //   logger.d('[WixAuthentication.login] wixManagedLoginUrl: $loginUrl');
  //
  //   final authCode = await _redirectToLoginUrl(loginUrl);
  //   logger.d('[WixAuthentication.login] code: $authCode');
  //
  //   // _tokens = await _getAuthCodeToken(authCode, pkcePair.codeVerifier);
  //   final authCodeToken = await _fetchAuthCodeToken(authCode, pkcePair.codeVerifier);
  //   logger.d('[WixAuthentication.tokens] tokens: $authCodeToken');
  //
  //   // await _storage.write(key: _tokensStorageKey, value: _tokens.toString());
  //
  //   logger.d('[WixAuthentication.login] end');
  // }
  Future<void> login(GrantType grantType) async {
    logger.d('[WixAuthentication.login] grantType: $grantType');
    await _loadingTokens.future;

    switch (grantType) {
      case GrantType.anonymous:
        await _loginAsVisitor();
        break;
      case GrantType.authorizationCode:
        await _loginAsMember();
        break;
    }
  }

  Future<void> logout() async {
    logger.d('[WixAuthentication.logout]');
    _setToken(null);
  }

  Future<LoginState> getLoginState() async {
    await _loadingTokens.future;

    if (_token == null) {
      return LoginState.loggedOut;
    }

    if (_token!.isExpired) {
      return _token!.grantType == GrantType.anonymous ? LoginState.visitorLoginExpired : LoginState.memberLoginExpired;
    }

    return _token!.grantType == GrantType.anonymous ? LoginState.loggedInAsVisitor : LoginState.loggedInAsMember;
  }

  String? get accessToken => (_token != null) ? _token!.accessToken : null;

  Future<void> _loginAsMember() async {
    logger.t('[WixAuthentication._loginAsMember] start');

    final loginState = await getLoginState();

    if (loginState == LoginState.loggedInAsMember) {
      logger.t('[WixAuthentication._loginAsMember] already logged in as member');
      return;
    }

    if (loginState == LoginState.memberLoginExpired) {
      logger.t('[WixAuthentication._loginAsMember] member login expired, refreshing token');
      await _renewToken();
      return;
    }

    if (loginState != LoginState.loggedInAsVisitor) {
      logger.t('[WixAuthentication._loginAsMember] logging in as visitor');
      await _loginAsVisitor();
    }

    final pkcePair = PkcePair.generate();
    final loginUrl = await _getManagedLoginUrl(pkcePair.codeChallenge);
    final authCode = await _redirectToLoginUrl(loginUrl);
    final token = await _fetchAuthCodeToken(authCode, pkcePair.codeVerifier);
    await _setToken(token);

    logger.t('[WixAuthentication.login] end');
  }

  // Future<Member> getMyMember() async {
  //   final http.Response response = await http.post(
  //     Uri.parse('https://www.wixapis.com/members/v1/members/my'),
  //     headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'},
  //   );
  // }

  Future<void> _loginAsVisitor() async {
    final loginState = await getLoginState();
    switch (loginState) {
      case LoginState.loggedInAsVisitor:
        logger.t('[WixAuthentication._loginAsVisitor] already logged in as visitor');
        return;
      case LoginState.loggedInAsMember:
        logger.t('[WixAuthentication._loginAsVisitor] already logged in as member');
        return;
      case LoginState.visitorLoginExpired:
        logger.t('[WixAuthentication._loginAsVisitor] visitor login expired, refreshing tokens');
        await _renewToken();
        return;
      case LoginState.memberLoginExpired:
        logger.t('[WixAuthentication._loginAsVisitor] member login expired, refreshing tokens');
        await _renewToken();
        return;
      case LoginState.loggedOut:
        logger.t('[WixAuthentication._loginAsVisitor] logged out, logging in as visitor');
        final body = await _fetchToken({
          'grantType': 'anonymous',
          'clientId': _clientId,
        });
        final token = Token.fromBody(GrantType.anonymous, body);
        await _setToken(token);
        return;
    }
  }

  Future<Token> _fetchAuthCodeToken(String authCode, String pkCodeVerifier) async {
    final body = await _fetchToken({
      'grantType': 'authorization_code',
      'clientId': _clientId,
      'code': authCode,
      'codeVerifier': pkCodeVerifier,
      'redirectUri': _redirectUri,
    });
    return Token.fromBody(GrantType.authorizationCode, body);
  }

  Future<void> _renewToken() async {
    final loginState = await getLoginState();
    if (loginState != LoginState.visitorLoginExpired && loginState != LoginState.memberLoginExpired) {
      throw Exception('Cannot renew token, current state: $loginState');
    }

    final body = await _fetchToken({
      'grantType': 'refresh_token',
      'clientId': _clientId,
      'refreshToken': _token!.refreshToken,
    });

    final token = Token.fromBody(_token!.grantType, body);
    await _setToken(token);
  }

  Future<String> _fetchToken(Map<String, dynamic> body) async {
    final http.Response response = await http.post(
      Uri.parse('https://www.wixapis.com/oauth2/token'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: body,
    );

    if (response.statusCode != 200) {
      throw Exception('Token exchange failed: ${response.body}');
    }

    logger.t('[WixAuthentication._fetchToken] Token response: ${response.body}');
    return response.body;
  }

  Future<void> _setToken(Token? token) async {
    logger.t('[WixAuthentication._setToken] token: $_token');
    _token = token;
    await _saveTokenToStorage();
  }

  Future<void> _loadTokenFromStorage() async {
    final token = await _storage.read(key: _tokenStorageKey);

    if (token != null) {
      _token = Token.fromString(token);
    }

    logger.t('[WixAuthentication._loadTokens] ${_token == null ? 'No tokens found in storage' : 'tokens: $_token'}');

    _loadingTokens.complete();
  }

  Future<void> _saveTokenToStorage() async {
    if (_token == null) {
      await _storage.delete(key: _tokenStorageKey);
      return;
    }

    await _storage.write(key: _tokenStorageKey, value: _token.toString());
  }

  Future<String> _getManagedLoginUrl(String pkCodeChallenge) async {
    final loginState = await getLoginState();
    if (loginState != LoginState.loggedInAsVisitor && loginState != LoginState.loggedInAsMember) {
      throw Exception(
          '[WixAuthentication._getManagedLoginUrl] Cannot get managed login URL - please login as visitor, current login state: $loginState');
    }

    final response = await http.post(
      Uri.parse('https://www.wixapis.com/redirect-session/v1/redirect-session'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_token!.accessToken}',
      },
      body: jsonEncode({
        'auth': {
          'authRequest': {
            'clientId': _clientId,
            'redirectUri': _redirectUri,
            'codeChallenge': pkCodeChallenge,
            'codeChallengeMethod': 'S256',
            'responseType': 'code',
            'responseMode': 'query',
            'scope': _scope,
            'state': PkcePair.generate().codeChallenge,
          }
        }
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to get login URL: ${response.body}');
    }

    logger.t('[WixAuthentication._getWixManagedLoginUrl] redirectSession response.body: ${response.body}');
    return jsonDecode(response.body)['redirectSession']['fullUrl'];
  }

  Future<String> _redirectToLoginUrl(String loginUrl) async {
    final String callbackUrlWithAuthToken = await FlutterWebAuth2.authenticate(
      url: loginUrl,
      callbackUrlScheme: Uri.parse(_redirectUri).scheme,
    );
    logger.t('[WixAuthentication._redirectToLoginUrl] callbackUrl: $callbackUrlWithAuthToken');

    final authCode = Uri.parse(callbackUrlWithAuthToken).queryParameters['code'];
    if (authCode == null) throw Exception('No authentication code returned from redirect URI');

    logger.t('[WixAuthentication._redirectToLoginUrl] authCode: $authCode');
    return authCode;
  }
}
