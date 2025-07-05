import 'token.dart';

enum LoginState {
  loggedInAsAnonymous,
  loggedInAsMember,
  anonymousLoginExpired,
  memberLoginExpired,
  loggedOut,
}

abstract class Authentication {
  Future<void> login();

  Future<void> logout();

  Future<dynamic> getMyMember();

  Token? get token;

  String? get accessToken => token?.accessToken;
}
