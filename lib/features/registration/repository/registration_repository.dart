import 'package:event_app/core/enum/http_method.dart';
import 'package:event_app/core/model/result.dart';
import 'package:event_app/core/network/network_service.dart';
import 'package:event_app/core/storage/storage_service.dart';
import 'package:event_app/features/registration/repository/model/registration_response.dart';
import 'package:event_app/features/registration/repository/model/token_response.dart';
import 'package:event_app/features/registration/repository/registration_repository_impl.dart';

class RegistrationRepository extends RegistrationRepositoryImpl {
  final NetworkService _networkService;
  final StorageService _storageService;

  RegistrationRepository({
    required NetworkService networkService,
    required StorageService storageService,
  }) : _networkService = networkService,
       _storageService = storageService;

  @override
  Future<Result<RegistrationResponse>> sendRegistration(
    String login,
    String password,
  ) async {
    try {
      final response = await _networkService.request(
        path: "registration",
        method: HttpMethod.post,
        body: {'login': login, 'password': password},
      );

      final authResponse = RegistrationResponse.fromJson(
        response as Map<String, dynamic>,
      );
      return Success(authResponse);
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<TokenResponse>> fetchToken(String login, String userId) async {
    try {
      final response = await _networkService.request(
        path: "token",
        method: HttpMethod.post,
        body: {'login': login, 'userId': userId},
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
  Future saveTokens(String accessToken, refreshToken) async {
    await _storageService.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
