// import 'dart:convert';
//
// import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
// import 'package:http/http.dart' as http;
//
// import '../../constants.dart';
//
// Future<void> loginWithWix() async {
//   final redirectUri = 'mywonder://auth-callback';
//   final scope = 'openid offline_access email profile';
//
//   final authUrl = getLoginUrl();
//
//   // Step 1: Launch the browser and wait for redirect
//   final result = await FlutterWebAuth2.authenticate(
//     url: authUrl,
//     callbackUrlScheme: 'mywonder',
//   );
//
//   // Step 2: Extract the auth code from redirect URL
//   final code = Uri.parse(result).queryParameters['code'];
//
//   if (code == null) throw Exception('No code returned');
//
//   // Step 3: Exchange code for token
//   final tokenResponse = await http.post(
//     Uri.parse('https://www.wixapis.com/oauth2/token'),
//     headers: {
//       'Content-Type': 'application/x-www-form-urlencoded',
//     },
//     body: {
//       'grantType': 'authorization_code',
//       'code': code,
//       'clientId': clientId,
//       'redirect_uri': redirectUri,
//     },
//   );
//
//   if (tokenResponse.statusCode != 200) {
//     throw Exception('Token exchange failed: ${tokenResponse.body}');
//   }
//
//   final tokens = jsonDecode(tokenResponse.body);
//   print('Access Token: ${tokens['access_token']}');
//   print('Refresh Token: ${tokens['refresh_token']}');
// }
