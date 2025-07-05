import '../src/client/authentication.dart';
import '../src/client/token.dart';

Token getMockToken(GrantType grantType) => Token(
      grantType: grantType,
      accessToken: 'mock_access_token',
      refreshToken: 'mock_refresh_token',
      expiresAt: DateTime.now().add(Duration(days: 1)),
    );

class MockAuthentication extends Authentication {
  LoginState _loginState = LoginState.loggedOut;
  Token? _token;
  String? _myMember;

  @override
  Token? get token => _token;

  @override
  Future<dynamic> getMyMember() async => _myMember;

  @override
  Future<void> login({GrantType grantType = GrantType.member}) async {
    switch (grantType) {
      case GrantType.anonymous:
        _loginAsVisitor();
        return;
      case GrantType.member:
        _loginAsMember();
        return;
    }
  }

  @override
  Future<void> logout() async {
    _myMember = null;
    _token = null;
    _loginState = LoginState.loggedOut;
  }

  Future<void> _loginAsVisitor() async {
    if (_loginState == LoginState.loggedInAsAnonymous ||
        _loginState == LoginState.loggedInAsMember) {
      return;
    }

    _myMember = 'mock_visitor';
    _token = getMockToken(GrantType.anonymous);
    _loginState = LoginState.loggedInAsAnonymous;
  }

  Future<void> _loginAsMember() async {
    if (_loginState == LoginState.loggedInAsMember) {
      return;
    }

    _myMember = 'mock_member';
    _token = getMockToken(GrantType.member);
    _loginState = LoginState.loggedInAsMember;
  }
}
