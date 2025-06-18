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
      "OauthNG.JWS.eyJraWQiOiJZSEJzdUpwSCIsImFsZyI6IkhTMjU2In0.eyJkYXRhIjoie1wiaW5zdGFuY2VcIjp7XCJpbnN0YW5jZUlkXCI6XCI5ZjRhNDMwNy02NzVlLTQ0ZjMtOGUwZi04NWEzNzdkYWZmM2RcIixcImFwcERlZklkXCI6XCIxYWM3NzMzNy1mYWVlLTQyMzMtOGY2Ny1kNzAwZmFhNTQ3ZGFcIixcInNpZ25EYXRlXCI6XCIyMDI1LTA2LTIxVDEyOjA0OjMwLjM4MlpcIixcInVpZFwiOlwiMTI0NmZlNGQtYzJlNC00MDZiLTljYjktYjJmZWRiZjUyYzNkXCIsXCJwZXJtaXNzaW9uc1wiOlwib2ZmbGluZV9hY2Nlc3NcIixcImRlbW9Nb2RlXCI6ZmFsc2UsXCJzaXRlT3duZXJJZFwiOlwiMTI0NmZlNGQtYzJlNC00MDZiLTljYjktYjJmZWRiZjUyYzNkXCIsXCJzaXRlTWVtYmVySWRcIjpcIjEyNDZmZTRkLWMyZTQtNDA2Yi05Y2I5LWIyZmVkYmY1MmMzZFwiLFwibWV0YVNpdGVJZFwiOlwiZDAzYTMwOWYtNTIwZi00YjdlLTkxNjItZGJiOTkyNDRjZWI3XCIsXCJleHBpcmF0aW9uRGF0ZVwiOlwiMjAyNS0wNi0yMVQxNjowNDozMC4zODJaXCIsXCJoYXNVc2VyUm9sZVwiOmZhbHNlLFwiYW9yXCI6ZmFsc2UsXCJzaWRcIjpcIjJjOWM0OTZiLWY3ZWQtNDUxMy04ZTc2LWM4ODI1Mzg3ZDYwN1wiLFwic2N0XCI6XCIyMDI1LTA2LTIxVDEyOjA0OjI1Ljg0MVpcIn19IiwiaWF0IjoxNzUwNTA3NDcwLCJleHAiOjE3NTA1MjE4NzB9.f_hVj9in1JqyQF5M7Tta6xNObR1p1iwmzhQvImXdqKE",
  "refreshToken":
      "JWS.eyJraWQiOiJZSEJzdUpwSCIsImFsZyI6IkhTMjU2In0.eyJkYXRhIjoiXCI5NDNiMjc5NC0xMDU4LTRhNzQtYWQ2Ni1lZGNmNDE4OWMwM2ZcIiIsImlhdCI6MTc1MDUwNzQ3MCwiZXhwIjoxNzgyMDQzNDcwfQ.t_ZH7iMGQpt8Cetj0BJuvRWw1JqrTh6gIY0fFIQmLxI",
  "expiresAt": "2025-06-21T19:04:27.495658",
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
