import 'dart:convert';

enum GrantType { anonymous, authorizationCode }

class Token {
  late GrantType grantType;
  late String accessToken;
  late String refreshToken;
  late DateTime expiresAt;

  Token.fromString(String tokensString) {
    final tokens = jsonDecode(tokensString);
    grantType = GrantType.values.byName(tokens['granType']);
    accessToken = tokens['accessToken'];
    refreshToken = tokens['refreshToken'];
    expiresAt = DateTime.parse(tokens['expiresAt']);
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
      'authType': grantType.toString(),
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'expiresAt': expiresAt.toIso8601String(),
    });
  }
}
