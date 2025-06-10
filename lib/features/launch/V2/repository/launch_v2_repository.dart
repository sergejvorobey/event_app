import 'package:event_app/core/enum/http_method.dart';
import 'package:event_app/core/model/result.dart';
import 'package:event_app/core/network/network_service.dart';
import 'package:event_app/core/storage/storage_service.dart';
import 'package:event_app/features/launch/V2/repository/launch_v2_repository_impl.dart';
import 'package:event_app/features/profile/model/profile_response.dart';
import 'package:event_app/features/registration/V1/repository/model/token_response.dart';

class LaunchV2Repository extends LaunchV2RepositoryImpl {
  final NetworkService _networkService;
  final StorageService _storageService;

  LaunchV2Repository({
    required NetworkService networkService,
    required StorageService storageService,
  }) : _networkService = networkService,
       _storageService = storageService;

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
  Future<Result<TokenResponse>> fetchToken() async {
    try {
      final access = await _storageService.getAccessToken() ?? "";
      final refresh = await _storageService.getRefreshToken() ?? "";
      final tokens = TokenResponse(
        accessToken: access,
        refreshToken: refresh,
        expiresIn: "",
      );
      if (access.isNotEmpty) {
        return Success(tokens);
      } else {
        return Failure(Exception('error'));
      }
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }
}
