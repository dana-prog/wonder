import 'dart:convert';

import '../logger.dart';

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
    return jsonEncode({'grantType': grantType.name, 'expiresAt': expiresAt.toIso8601String()});
  }

  dynamic toJson() {
    return {
      'grantType': grantType.name,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'expiresAt': expiresAt.toIso8601String(),
    };
  }

  factory Token.fromJson(Map<String, String> json) {
    return Token(
      grantType: GrantType.values.firstWhere((e) => e.name == json['grantType']),
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
    );
  }

  factory Token.fromJsonStr(String jsonStr) {
    final Map<String, String> json = jsonDecode(jsonStr);
    return Token.fromJson(json);
  }
}
