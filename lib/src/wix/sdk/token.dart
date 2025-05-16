import 'dart:convert';

enum GrantType { anonymous, authorizationCode }

class Token {
  late GrantType grantType;
  late String accessToken;
  late String refreshToken;
  late DateTime expiresAt;

  Token.fromString(String tokenString) {
    final token = jsonDecode(tokenString);
    grantType = GrantType.values.byName(token['grantType']);
    accessToken = token['accessToken'];
    refreshToken = token['refreshToken'];
    expiresAt = DateTime.parse(token['expiresAt']);
  }

  Token.fromBody(GrantType type, String bodyString) {
    grantType = type;
    final bodyProps = jsonDecode(bodyString);
    accessToken = bodyProps['access_token'] as String;
    refreshToken = bodyProps['refresh_token'] as String;
    expiresAt = DateTime.now().add(
      Duration(seconds: bodyProps['expires_in'] as int),
    );
  }

  bool get isExpired {
    return DateTime.now().isAfter(expiresAt);
  }

  @override
  String toString() {
    return jsonEncode({
      'grantType': grantType.name,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'expiresAt': expiresAt.toIso8601String(),
    });
  }
}
