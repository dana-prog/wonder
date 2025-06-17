import 'dart:convert';

import 'package:wonder/src/logger.dart';

enum GrantType {
  anonymous,
  member;

  String getWixLabel() {
    switch (this) {
      case GrantType.anonymous:
        return 'anonymous';
      case GrantType.member:
        return 'authorization_code';
    }
  }
}

class Token {
  late GrantType grantType;
  late String accessToken;
  late String refreshToken;
  late DateTime expiresAt;

  Token({
    required this.grantType,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });

  static Token fromString(String tokenString) {
    final token = jsonDecode(tokenString);
    return Token(
      grantType: GrantType.values.byName(token['grantType']),
      accessToken: token['accessToken'],
      refreshToken: token['refreshToken'],
      expiresAt: DateTime.parse(token['expiresAt']),
    );
  }

  bool get isValid {
    try {
      return DateTime.now().isBefore(expiresAt);
    } catch (e) {
      logger.e('[Token.isValid] Error checking expiration: $e');
      return false; // If there's an error, assume the token is not valid
    }
  }

  GrantType get type => grantType;

  @override
  String toString() {
    return jsonEncode({
      'grantType': grantType.name,
      'expiresAt': expiresAt.toIso8601String(),
    });
  }

  String toFullString() {
    return jsonEncode({
      'grantType': grantType.name,
      'expiresAt': expiresAt.toIso8601String(),
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    });
  }
}
