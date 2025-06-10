import 'package:event_app/core/model/result.dart';
import 'package:event_app/core/network/network_sevice_v2.dart';
import 'package:event_app/core/storage/storage_service.dart';
import 'package:event_app/core/ui/common_text_field_handle.dart';
import 'package:event_app/core/validation/input_validators.dart';
import 'package:event_app/features/registration/V1/repository/registration_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<LoginChanged>((event, emit) {
      _onLoginChanged(event, emit);
    });
    on<PasswordChanged>((event, emit) {
      _onPasswordChanged(event, emit);
    });
    on<ConfirmPasswordChanged>((event, emit) {
      _onConfirmPasswordChanged(event, emit);
    });
    on<RegistrationButtonPressed>(_onRegistrationButtonPressed);
    on<FetchToken>(_onFetchToken);
  }

  final RegistrationRepository _repository = RegistrationRepository(
    networkService: NetworkServiceV2(),
    storageService: StorageService(),
  );

  void _onLoginChanged(LoginChanged event, Emitter<RegistrationState> emit) {
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

  void _onPasswordChanged(
    PasswordChanged event,
    Emitter<RegistrationState> emit,
  ) {
    final password = event.password;
    final confirmPassword = state.confirmPassword?.value ?? "";

    final passwordMessage = validatePassword(password, confirmPassword);
    final confirmPasswordMessage = validateConfirmPassword(
      password,
      confirmPassword,
    );

    emit(
      state.copyWith(
        password: state.password?.copyWith(
          value: password,
          label: "Пароль",
          placeholder: "Введите пароль",
          message: passwordMessage,
        ),
        confirmPassword: state.confirmPassword?.copyWith(
          message: confirmPasswordMessage,
        ),
      ),
    );
  }

  void _onConfirmPasswordChanged(
    ConfirmPasswordChanged event,
    Emitter<RegistrationState> emit,
  ) {
    final confirmPassword = event.password;
    final password = state.password?.value ?? "";

    final confirmPasswordMessage = validateConfirmPassword(
      password,
      confirmPassword,
    );
    final passwordMessage = validatePassword(password, "");

    emit(
      state.copyWith(
        confirmPassword: state.confirmPassword?.copyWith(
          value: confirmPassword,
          label: "Повторите пароль",
          placeholder: "Введите пароль",
          message: confirmPasswordMessage,
        ),
        password: state.password?.copyWith(message: passwordMessage),
      ),
    );
  }

  void _onRegistrationButtonPressed(
    RegistrationButtonPressed event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(
      RegistrationLoading(
        login: state.login,
        password: state.password,
        confirmPassword: state.confirmPassword,
      ),
    );

    final result = await _repository.sendRegistration(
      event.login,
      event.password,
    );
    switch (result) {
      case Success(value: final regResponse):
        emit(
          RegistrationSuccess(
            userId: regResponse.userId,
            login: state.login,
            password: state.password,
            confirmPassword: state.confirmPassword,
          ),
        );
      case Failure(exception: final exception):
        emit(
          RegistrationError(
            exception.toString(),
            login: state.login,
            password: state.password,
            confirmPassword: state.confirmPassword,
          ),
        );
    }
  }

  void _onFetchToken(FetchToken event, Emitter<RegistrationState> emit) async {
    emit(
      RegistrationLoading(
        login: state.login,
        password: state.password,
        confirmPassword: state.confirmPassword,
      ),
    );

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
            confirmPassword: state.confirmPassword,
          ),
        );
    }
  }
}
