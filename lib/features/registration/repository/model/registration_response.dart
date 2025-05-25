class RegistrationResponse {
  final String message;
  final String login;
  final String userId;

  RegistrationResponse({
    required this.message,
    required this.login,
    required this.userId,
  });

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) {
    return RegistrationResponse(
      message: json['message'],
      login: json['login'],
      userId: json['userId'],
    );
  }
}
