import 'package:event_app/core/enum/http_method.dart';
import 'package:event_app/core/model/result.dart';
import 'package:event_app/core/network/network_service.dart';
import 'package:event_app/features/auth/repository/auth_repository_impl.dart';
import 'package:event_app/features/auth/repository/model/auth_response.dart';

class AuthRepository extends AuthRepositoryImpl {
  final NetworkService networkService;

  AuthRepository({required this.networkService});

  @override
  Future<Result<AuthResponse>> sendAuth(String login, String password) async {
    try {
      final response = await networkService.request(
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
}
