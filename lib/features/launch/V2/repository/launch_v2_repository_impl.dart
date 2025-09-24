import 'package:event_app/core/model/result.dart';
import 'package:event_app/features/user/profile/model/profile_response.dart';
import 'package:event_app/features/auth/registration/V1/repository/model/token_response.dart';

abstract class LaunchV2RepositoryImpl {
  Future<Result<ProfileResponse>> fetchProfile();
  Future<Result<TokenResponse>> fetchToken();
}
