import 'package:event_app/core/model/result.dart';
import 'package:event_app/features/auth/V1/repository/model/auth_response.dart';
import 'package:event_app/features/auth/registration/V1/repository/model/token_response.dart';

abstract class AuthRepositoryImpl {
  Future<Result<AuthResponse>> sendAuth(String login, String password);
  Future<Result<TokenResponse>> fetchToken(String login, String userId);
  Future saveTokens(String accessToken, refreshToken);
}
