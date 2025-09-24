import 'package:event_app/core/model/result.dart';
import 'package:event_app/features/auth/login/models/login_response.dart';

abstract class LoginRepositoryImpl {
  Future<Result<LoginResponse>> sendLogin(String login, String password);
  Future saveTokens({required String accessToken, refreshToken});
}
