import 'package:event_app/core/model/result.dart';
import 'package:event_app/features/user/profile/model/profile_response.dart';

abstract class ResumeRepositoiryImpl {
  Future<Result<ProfileResponse>> fetchProfile();
}
