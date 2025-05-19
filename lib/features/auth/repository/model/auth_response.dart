class AuthResponse {
  final String login;
  final String userId;

  AuthResponse({required this.login, required this.userId});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      login: json['login'],
      userId: json['userId']
    );
  }
}
