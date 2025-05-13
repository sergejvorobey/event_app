import 'package:event_app/core/model/result.dart';
import 'package:event_app/features/auth/repository/model/auth_response.dart';

abstract class AuthRepositoryImpl {
  Future<Result<AuthResponse>> sendAuth(String login, String password);
}