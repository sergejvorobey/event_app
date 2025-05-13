import 'package:event_app/core/model/result.dart';
import 'package:event_app/core/network/network_service.dart';
import 'package:event_app/features/auth/repository/auth_repository_impl.dart';
import 'package:event_app/features/auth/repository/model/auth_response.dart';

class AuthRepository extends AuthRepositoryImpl {
  final NetworkService networkService;

  AuthRepository({required this.networkService});

  @override
  Future<Result<AuthResponse>> sendAuth(String login, String password) {
    print(login);
    print(password);
    return Future.value(Failure(Exception("Auth failed")));
  }
}
