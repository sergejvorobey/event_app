import 'package:event_app/core/model/result.dart';
import 'package:event_app/features/auth/registration/V1/repository/model/token_response.dart';

abstract class RegistrationRepositoryImpl {
  Future<Result<TokenResponse>> sendRegistration(String login, String password);
  Future saveTokens({required String accessToken, refreshToken});
}
