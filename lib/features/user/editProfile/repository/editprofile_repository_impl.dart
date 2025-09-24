import 'package:event_app/core/model/result.dart';
import 'package:event_app/features/user/profile/model/profile_response.dart';

abstract class EditprofileRepositoryImpl {
  Future<Result<ProfileResponse>> fetchProfile();
  Future<Result<ProfileResponse>> updateProfile(
    String firstName,
    lastName,
    city,
    email,
  );
}
