class ProfileResponse {
  String login;
  String firstName;
  String lastName;
  String phoneNumber;
  String city;
  String email;
  String avatarUrl;
  bool isNewUser;
  String createdOn;

  ProfileResponse({
    required this.login,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.city,
    required this.email,
    required this.avatarUrl,
    required this.isNewUser,
    required this.createdOn,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      login: json['login'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      city: json['city'],
      email: json['email'],
      avatarUrl: json['avatarUrl'],
      isNewUser: json['isNewUser'],
      createdOn: json['createdOn'],
    );
  }
}