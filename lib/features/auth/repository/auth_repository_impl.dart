import 'package:event_app/core/model/result.dart';
import 'package:event_app/features/auth/repository/model/auth_response.dart';
import 'package:event_app/features/registration/repository/model/token_response.dart';

abstract class AuthRepositoryImpl {
  Future<Result<AuthResponse>> sendAuth(String login, String password);
  Future<Result<TokenResponse>> fetchToken(String login, String userId);
  Future saveTokens(String accessToken, refreshToken);
}