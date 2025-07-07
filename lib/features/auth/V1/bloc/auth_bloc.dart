import 'package:event_app/core/model/result.dart';
import 'package:event_app/core/network/network_sevice_v2.dart';
import 'package:event_app/core/storage/storage_service.dart';
import 'package:event_app/core/ui/common_text_field_handler.dart';
import 'package:event_app/core/validation/input_validators.dart';
import 'package:event_app/features/auth/V1/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginChanged>((event, emit) {
      _onLoginChanged(event, emit);
    });
    on<PasswordChanged>((event, emit) {
      _onPasswordChanged(event, emit);
    });
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<RecoverButtonPressed>(_navigateToRecoverPasswordScreen);
    on<FetchToken>(_onFetchToken);
  }

  final AuthRepository _repository = AuthRepository(
    networkService: NetworkServiceV2(),
    storageService: StorageService(),
  );

  void _onLoginChanged(LoginChanged event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        login: state.login?.copyWith(
          value: event.login,
          label: "Логин",
          placeholder: "Введите логин",
          message: validateLogin(event.login),
        ),
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        password: state.password?.copyWith(
          value: event.password,
          label: "Пароль",
          placeholder: "Введите пароль",
          message: validatePassword(event.password, ""),
        ),
      ),
    );
  }

  void _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading(login: state.login, password: state.password));

    final result = await _repository.sendAuth(event.login, event.password);
    switch (result) {
      case Success(value: final authResponse):
        emit(
          AuthSuccess(
            userId: authResponse.userId,
            login: state.login,
            password: state.password,
          ),
        );
      case Failure(exception: final exception):
        emit(
          AuthError(
            exception.toString(),
            login: state.login,
            password: state.password,
          ),
        );
    }
  }

  void _navigateToRecoverPasswordScreen(
    RecoverButtonPressed event,
    Emitter<AuthState> emit,
  ) {
    // TODO: - Доделать кнопку вост.пароль
    emit(AuthInitial());
  }

  void _onFetchToken(FetchToken event, Emitter<AuthState> emit) async {
    emit(AuthLoading(login: state.login, password: state.password));

    final result = await _repository.fetchToken(
      state.login?.value ?? "",
      event.userId,
    );
    switch (result) {
      case Success(value: final tokenResponse):
        _repository.saveTokens(
          tokenResponse.accessToken,
          tokenResponse.refreshToken,
        );
        emit(TokenSuccess());
      case Failure(exception: final exception):
        emit(
          TokenError(
            exception.toString(),
            login: state.login,
            password: state.password,
          ),
        );
    }
  }
}
