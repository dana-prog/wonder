import 'package:flutter/material.dart' hide Chip;
import 'package:wonder/src/client/token.dart';
import 'package:wonder/src/client/wix/wix_client.dart';

import '../utils/default_future_builder.dart';
import 'api_calls.dart';
import 'authentication_button.dart';

const _title = 'Wonder API Playground';

Token _mockToken = Token.fromJson({
  "grantType": "member",
  "accessToken":
      "OauthNG.JWS.eyJraWQiOiJZSEJzdUpwSCIsImFsZyI6IkhTMjU2In0.eyJkYXRhIjoie1wiaW5zdGFuY2VcIjp7XCJpbnN0YW5jZUlkXCI6XCI5ZjRhNDMwNy02NzVlLTQ0ZjMtOGUwZi04NWEzNzdkYWZmM2RcIixcImFwcERlZklkXCI6XCIxYWM3NzMzNy1mYWVlLTQyMzMtOGY2Ny1kNzAwZmFhNTQ3ZGFcIixcInNpZ25EYXRlXCI6XCIyMDI1LTA2LTIyVDEwOjM4OjI2LjM2NVpcIixcInVpZFwiOlwiMTI0NmZlNGQtYzJlNC00MDZiLTljYjktYjJmZWRiZjUyYzNkXCIsXCJwZXJtaXNzaW9uc1wiOlwib2ZmbGluZV9hY2Nlc3NcIixcImRlbW9Nb2RlXCI6ZmFsc2UsXCJzaXRlT3duZXJJZFwiOlwiMTI0NmZlNGQtYzJlNC00MDZiLTljYjktYjJmZWRiZjUyYzNkXCIsXCJzaXRlTWVtYmVySWRcIjpcIjEyNDZmZTRkLWMyZTQtNDA2Yi05Y2I5LWIyZmVkYmY1MmMzZFwiLFwibWV0YVNpdGVJZFwiOlwiZDAzYTMwOWYtNTIwZi00YjdlLTkxNjItZGJiOTkyNDRjZWI3XCIsXCJleHBpcmF0aW9uRGF0ZVwiOlwiMjAyNS0wNi0yMlQxNDozODoyNi4zNjVaXCIsXCJoYXNVc2VyUm9sZVwiOmZhbHNlLFwiYW9yXCI6ZmFsc2UsXCJzaWRcIjpcIjBmY2QyMTMzLTMzNDQtNGIzMy1hYmJiLTdhZTlhYTczMGFmMVwiLFwic2N0XCI6XCIyMDI1LTA2LTIyVDEwOjM4OjE5LjY5M1pcIn19IiwiaWF0IjoxNzUwNTg4NzA2LCJleHAiOjE3NTA2MDMxMDZ9.pyCycLVcf3IBaQcoYvLsVYwLck9x6E9ln3C-BkViXPs",
  "refreshToken":
      "JWS.eyJraWQiOiJZSEJzdUpwSCIsImFsZyI6IkhTMjU2In0.eyJkYXRhIjoiXCJiMmJjZDQ0MS02NDljLTQxMDMtODllZC02ZTBkYjY3MGQ5NWRcIiIsImlhdCI6MTc1MDU4ODcwNiwiZXhwIjoxNzgyMTI0NzA2fQ.gXmY2751l2bkXU_hydMdX8dJLPk-oHrcfIb6SAIS68U",
  "expiresAt": "2025-06-22T17:38:25.274978",
});

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: DefaultFutureBuilder<WixClient>(
        future: WixClient.create(
          authRedirectUrl: 'wonderapiapp://authorization',
          token: _mockToken,
        ),
        // future: WixClient.create(authRedirectUrl: 'http://localhost:9017/authorization'),
        builder: (context, client) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ApiCalls(client),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: AuthenticationButton(authentication: client.authentication),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
