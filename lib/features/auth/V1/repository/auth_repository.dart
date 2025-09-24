import 'package:event_app/core/enum/http_method.dart';
import 'package:event_app/core/model/result.dart';
import 'package:event_app/core/network/network_sevice_v2.dart';
import 'package:event_app/core/storage/storage_service.dart';
import 'package:event_app/features/auth/V1/repository/auth_repository_impl.dart';
import 'package:event_app/features/auth/V1/repository/model/auth_response.dart';
import 'package:event_app/features/auth/registration/V1/repository/model/token_response.dart';

class AuthRepository extends AuthRepositoryImpl {
  final NetworkServiceV2 _networkService;
  final StorageService _storageService;

  AuthRepository({
    required NetworkServiceV2 networkService,
    required StorageService storageService,
  }) : _networkService = networkService,
       _storageService = storageService;

  @override
  Future<Result<AuthResponse>> sendAuth(String login, String password) async {
    try {
      final response = await _networkService.request(
        path: "auth",
        method: HttpMethod.post,
        body: {'login': login, 'password': password},
      );

      final authResponse = AuthResponse.fromJson(
        response as Map<String, dynamic>,
      );
      return Success(authResponse);
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
}
