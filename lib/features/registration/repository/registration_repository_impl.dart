import 'package:event_app/core/model/result.dart';
import 'package:event_app/features/registration/repository/model/registration_response.dart';
import 'package:event_app/features/registration/repository/model/token_response.dart';

abstract class RegistrationRepositoryImpl {
  Future<Result<RegistrationResponse>> sendRegistration(String login, String password);
  Future<Result<TokenResponse>> fetchToken(String login, String userId);
  Future saveTokens(String accessToken, refreshToken);
}