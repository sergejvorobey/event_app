class AuthResponse {
  final String _login;
  final String _userId;

  AuthResponse({required String login, required String userId})
      : _login = login,
        _userId = userId;
}