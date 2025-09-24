import 'package:event_app/core/enum/http_method.dart';
import 'package:event_app/core/model/result.dart';
import 'package:event_app/core/network/network_sevice_v2.dart';
import 'package:event_app/core/storage/storage_service.dart';
import 'package:event_app/features/auth/registration/V1/repository/model/token_response.dart';
import 'package:event_app/features/auth/registration/V1/repository/registration_repository_impl.dart';

class RegistrationRepository extends RegistrationRepositoryImpl {
  final NetworkServiceV2 _networkService;
  final StorageService _storageService;

  RegistrationRepository({
    required NetworkServiceV2 networkService,
    required StorageService storageService,
  }) : _networkService = networkService,
       _storageService = storageService;

  @override
  Future<Result<TokenResponse>> sendRegistration(
    String login,
    String password,
  ) async {
    try {
      final response = await _networkService.request(
        path: "/auth/registration",
        method: HttpMethod.post,
        body: {'login': login, 'password': password},
      );

      final tokenResponse = TokenResponse.fromJson(
        response as Map<String, dynamic>,
      );
      return Success(tokenResponse);
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future saveTokens({required String accessToken, refreshToken}) async {
    await _storageService.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
