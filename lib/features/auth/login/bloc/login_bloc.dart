import 'package:event_app/core/model/result.dart';
import 'package:event_app/core/network/network_sevice_v2.dart';
import 'package:event_app/core/storage/storage_service.dart';
import 'package:event_app/core/ui/common_text_field_handler.dart';
import 'package:event_app/core/validation/input_validators.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/features/auth/login/repository/login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginChanged>((event, emit) {
      _onLoginChanged(event, emit);
    });
    on<PasswordChanged>((event, emit) {
      _onPasswordChanged(event, emit);
    });
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<RecoverButtonPressed>(_navigateToRecoverPasswordScreen);
  }

  final LoginRepository _repository = LoginRepository(
    networkService: NetworkServiceV2(),
    storageService: StorageService(),
  );

  void _onLoginChanged(LoginChanged event, Emitter<LoginState> emit) {
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

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
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
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading(login: state.login, password: state.password));

    final result = await _repository.sendLogin(event.login, event.password);
    switch (result) {
      case Success(value: final loginResponse):
        await _repository.saveTokens(
          accessToken: loginResponse.accessToken,
          refreshToken: loginResponse.refreshToken,
        );
        emit(LoginContent());
      case Failure(exception: final exception):
        emit(
          LoginError(
            exception.toString(),
            login: state.login,
            password: state.password,
          ),
        );
    }
  }

  void _navigateToRecoverPasswordScreen(
    RecoverButtonPressed event,
    Emitter<LoginState> emit,
  ) {
    // TODO: - Доделать кнопку вост.пароль
    emit(LoginInitial());
  }
}
