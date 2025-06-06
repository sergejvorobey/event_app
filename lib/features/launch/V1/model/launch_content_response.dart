import 'package:json_annotation/json_annotation.dart';

part 'launch_content_response.g.dart';

@JsonSerializable()
class LaunchContentResponse {
  final String login;
  final String userId;

  LaunchContentResponse({required this.login, required this.userId});

  factory LaunchContentResponse.fromJson(Map<String, dynamic> json) =>
      _$LaunchContentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LaunchContentResponseToJson(this);
}