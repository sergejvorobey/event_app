import 'package:event_app/core/model/result.dart';
import 'package:event_app/core/network/network_service.dart';
import 'package:event_app/core/ui/common_text_field_handle.dart';
import 'package:event_app/core/validation/input_validators.dart';
import 'package:event_app/features/auth/repository/auth_repository.dart';
import 'package:flutter/rendering.dart';
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
  }

  final AuthRepository _repository = AuthRepository(
    networkService: NetworkService(),
  );

  void _onLoginChanged(LoginChanged event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        login: state.login?.copyWith(
          value: event.login,
          label: "Логин",
          placeholder: "Введите логин",
          message: validateLogin(event.login)
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
          message: validatePassword(event.password),
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
        // emit(AuthSuccess());
        print(authResponse);
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
    // Просто меняем состояние (навигацию обработаем в UI)
    emit(AuthInitial());
  }
}