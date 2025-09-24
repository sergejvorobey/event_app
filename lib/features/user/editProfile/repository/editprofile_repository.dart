import 'package:event_app/core/enum/http_method.dart';
import 'package:event_app/core/model/result.dart';
import 'package:event_app/core/network/network_sevice_v2.dart';
import 'package:event_app/features/user/editProfile/repository/editprofile_repository_impl.dart';
import 'package:event_app/features/user/profile/model/profile_response.dart';
import 'package:get_it/get_it.dart';

class EditprofileRepository extends EditprofileRepositoryImpl {
  final _networkService = GetIt.I<NetworkServiceV2>();

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

  @override
  Future<Result<ProfileResponse>> updateProfile(
    String firstName,
    lastName,
    city,
    email,
  ) async {
    try {
      final response = await _networkService.request(
        path: "profile/edit",
        method: HttpMethod.post,
        body: {
          'firstName': firstName,
          'lastName': lastName,
          'city': city,
          'email': email,
        },
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
