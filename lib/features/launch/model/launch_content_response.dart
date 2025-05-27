class LaunchContentResponse {
  final String login;
  final String userId;

  LaunchContentResponse({
    required this.login,
    required this.userId
  });

  factory LaunchContentResponse.fromJson(Map<String, dynamic> json) {
    return LaunchContentResponse(
      login: json['login'],
      userId: json['userId']
    );
  }
}