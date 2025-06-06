import 'package:event_app/core/model/result.dart';
import 'package:event_app/features/profile/model/profile_response.dart';

abstract class ProfileRepositoryImpl {
  Future<Result<ProfileResponse>> fetchProfile();
}
