import 'package:event_app/core/enum/http_method.dart';
import 'package:event_app/core/model/result.dart';
import 'package:event_app/core/network/network_service.dart';
import 'package:event_app/features/profile/model/profile_response.dart';
import 'package:event_app/features/profile/repository/profile_repository_impl.dart';

class ProfileRepository extends ProfileRepositoryImpl {
  final NetworkService _networkService;

  ProfileRepository({required NetworkService networkService})
    : _networkService = networkService;

  @override
  Future<Result<ProfileResponse>> fetchProfile() async {
    try {
      final response = await _networkService.request(
        path: "profile",
        method: HttpMethod.get,
      );

      final profileResponse = ProfileResponse.fromJson(
        response as Map<String, dynamic>,
      );
      return Success(profileResponse);
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }
}
