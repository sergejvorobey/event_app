import 'package:event_app/core/enum/http_method.dart';
import 'package:event_app/core/model/result.dart';
import 'package:event_app/core/network/network_sevice_v2.dart';
import 'package:event_app/core/storage/storage_service.dart';
import 'package:event_app/features/auth/login/models/login_response.dart';
import 'package:event_app/features/auth/login/repository/login_repository_impl.dart';

class LoginRepository extends LoginRepositoryImpl {
  final NetworkServiceV2 _networkService;
  final StorageService _storageService;

  LoginRepository({
    required NetworkServiceV2 networkService,
    required StorageService storageService,
  }) : _networkService = networkService,
       _storageService = storageService;

  @override
  Future<Result<LoginResponse>> sendLogin(String login, String password) async {
    try {
      final response = await _networkService.request(
        path: "auth/login",
        method: HttpMethod.post,
        body: {'login': login, 'password': password},
      );

      final authResponse = LoginResponse.fromJson(
        response as Map<String, dynamic>,
      );
      return Success(authResponse);
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
