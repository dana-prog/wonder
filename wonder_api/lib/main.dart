import 'package:flutter/material.dart';
import 'package:wonder/src/client/authentication.dart';
import 'package:wonder/src/client/token.dart';
import 'package:wonder/src/client/wix/wix_api_service.dart';
import 'package:wonder/src/client/wix/wix_authentication.dart';
import 'package:wonder/src/theme/app_theme.dart';

import 'src/widgets/home.dart';

const _authRedirectUrl = 'wonderapiapp://authorization';

Map<String, dynamic> _tokenResponseBody = {
  "access_token":
      "OauthNG.JWS.eyJraWQiOiJZSEJzdUpwSCIsImFsZyI6IkhTMjU2In0.eyJkYXRhIjoie1wiaW5zdGFuY2VcIjp7XCJpbnN0YW5jZUlkXCI6XCI5ZjRhNDMwNy02NzVlLTQ0ZjMtOGUwZi04NWEzNzdkYWZmM2RcIixcImFwcERlZklkXCI6XCIxYWM3NzMzNy1mYWVlLTQyMzMtOGY2Ny1kNzAwZmFhNTQ3ZGFcIixcInNpZ25EYXRlXCI6XCIyMDI1LTA2LTMwVDA4OjA4OjMxLjU0N1pcIixcInVpZFwiOlwiMTI0NmZlNGQtYzJlNC00MDZiLTljYjktYjJmZWRiZjUyYzNkXCIsXCJwZXJtaXNzaW9uc1wiOlwib2ZmbGluZV9hY2Nlc3NcIixcImRlbW9Nb2RlXCI6ZmFsc2UsXCJzaXRlT3duZXJJZFwiOlwiMTI0NmZlNGQtYzJlNC00MDZiLTljYjktYjJmZWRiZjUyYzNkXCIsXCJzaXRlTWVtYmVySWRcIjpcIjEyNDZmZTRkLWMyZTQtNDA2Yi05Y2I5LWIyZmVkYmY1MmMzZFwiLFwibWV0YVNpdGVJZFwiOlwiZDAzYTMwOWYtNTIwZi00YjdlLTkxNjItZGJiOTkyNDRjZWI3XCIsXCJleHBpcmF0aW9uRGF0ZVwiOlwiMjAyNS0wNi0zMFQxMjowODozMS41NDdaXCIsXCJoYXNVc2VyUm9sZVwiOmZhbHNlLFwiYW9yXCI6ZmFsc2UsXCJzaWRcIjpcIjBmY2QyMTMzLTMzNDQtNGIzMy1hYmJiLTdhZTlhYTczMGFmMVwiLFwic2N0XCI6XCIyMDI1LTA2LTIyVDEwOjM4OjE5LjY5M1pcIn19IiwiaWF0IjoxNzUxMjcwOTExLCJleHAiOjE3NTEyODUzMTF9.95dHV_h0pUlgYHECOgAAMZF0X5oUklDPM7luhqEJFQA",
  "token_type": "Bearer",
  "expires_in": 14400,
  "refresh_token":
      "JWS.eyJraWQiOiJZSEJzdUpwSCIsImFsZyI6IkhTMjU2In0.eyJkYXRhIjoiXCJiMmJjZDQ0MS02NDljLTQxMDMtODllZC02ZTBkYjY3MGQ5NWRcIiIsImlhdCI6MTc1MTI3MDkxMSwiZXhwIjoxNzgyODA2OTExfQ.HjuCVHTIr22X1BGpr-Opu3yUVwoLdZrQ_v8pG9EPs5Y",
};

Token _mockToken = ResponseBodyFormatters.responseBodyToToken(
  grantType: GrantType.member,
  body: _tokenResponseBody,
)!;

// Token _mockToken = Token.fromJson({
//   "grantType": "member",
//   "accessToken":
//       "OauthNG.JWS.eyJraWQiOiJZSEJzdUpwSCIsImFsZyI6IkhTMjU2In0.eyJkYXRhIjoie1wiaW5zdGFuY2VcIjp7XCJpbnN0YW5jZUlkXCI6XCI5ZjRhNDMwNy02NzVlLTQ0ZjMtOGUwZi04NWEzNzdkYWZmM2RcIixcImFwcERlZklkXCI6XCIxYWM3NzMzNy1mYWVlLTQyMzMtOGY2Ny1kNzAwZmFhNTQ3ZGFcIixcInNpZ25EYXRlXCI6XCIyMDI1LTA2LTI2VDA2OjQ5OjIxLjAxM1pcIixcInVpZFwiOlwiMTI0NmZlNGQtYzJlNC00MDZiLTljYjktYjJmZWRiZjUyYzNkXCIsXCJwZXJtaXNzaW9uc1wiOlwib2ZmbGluZV9hY2Nlc3NcIixcImRlbW9Nb2RlXCI6ZmFsc2UsXCJzaXRlT3duZXJJZFwiOlwiMTI0NmZlNGQtYzJlNC00MDZiLTljYjktYjJmZWRiZjUyYzNkXCIsXCJzaXRlTWVtYmVySWRcIjpcIjEyNDZmZTRkLWMyZTQtNDA2Yi05Y2I5LWIyZmVkYmY1MmMzZFwiLFwibWV0YVNpdGVJZFwiOlwiZDAzYTMwOWYtNTIwZi00YjdlLTkxNjItZGJiOTkyNDRjZWI3XCIsXCJleHBpcmF0aW9uRGF0ZVwiOlwiMjAyNS0wNi0yNlQxMDo0OToyMS4wMTNaXCIsXCJoYXNVc2VyUm9sZVwiOmZhbHNlLFwiYW9yXCI6ZmFsc2UsXCJzaWRcIjpcIjBmY2QyMTMzLTMzNDQtNGIzMy1hYmJiLTdhZTlhYTczMGFmMVwiLFwic2N0XCI6XCIyMDI1LTA2LTIyVDEwOjM4OjE5LjY5M1pcIn19IiwiaWF0IjoxNzUwOTIwNTYxLCJleHAiOjE3NTA5MzQ5NjF9.0Iymzqw3QOrOCg9bwpW6pIekho1Thc4hcmGSdSJ_OR8",
//   "refreshToken":
//       "JWS.eyJraWQiOiJZSEJzdUpwSCIsImFsZyI6IkhTMjU2In0.eyJkYXRhIjoiXCJiMmJjZDQ0MS02NDljLTQxMDMtODllZC02ZTBkYjY3MGQ5NWRcIiIsImlhdCI6MTc1MDkyMDU2MSwiZXhwIjoxNzgyNDU2NTYxfQ.OSbpJ4CUWpDtWsNXDEj52W_Gm5F2V4oG0BzqKmar1SE",
//   "expiresAt": "2025-06-26T13:50:10.068",
// });

void main() async {
  final authentication = await WixAuthentication.create(
    authRedirectUrl: _authRedirectUrl,
    token: _mockToken,
  );
  if (authentication.token?.isValid == false) {
    await authentication.renewToken();
  }

  runApp(WonderApiApp(authentication: authentication));
}

class WonderApiApp extends StatelessWidget {
  final Authentication authentication;
  const WonderApiApp({required this.authentication, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wonder API Playground',
      theme: AppTheme.light,
      home: Home(authentication: authentication),
    );
  }
}
