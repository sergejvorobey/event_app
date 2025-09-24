part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  // MARK: - Property

  final CommonTextFieldHandler? login;
  final CommonTextFieldHandler? password;
  final CommonTextFieldHandler? confirmPassword;
  final bool isButtonEnabled;

  const RegistrationState({
    this.login,
    this.password,
    this.confirmPassword,
    this.isButtonEnabled = false,
  });

  RegistrationState copyWith({
    CommonTextFieldHandler? login,
    CommonTextFieldHandler? password,
    CommonTextFieldHandler? confirmPassword,
    bool? isButtonEnabled,
  }) {
    final updatedLogin = login ?? this.login;
    final updatedPassword = password ?? this.password;
    final updatedConfirmPassword = confirmPassword ?? this.confirmPassword;

    final loginValid = updatedLogin?.message.isEmpty ?? false;
    final passwordValid = updatedPassword?.message.isEmpty ?? false;
    final confirmPasswordValid =
        updatedConfirmPassword?.message.isEmpty ?? false;

    return RegistrationState(
      login: updatedLogin,
      password: updatedPassword,
      confirmPassword: updatedConfirmPassword,
      isButtonEnabled:
          isButtonEnabled ??
          (loginValid && passwordValid && confirmPasswordValid),
    );
  }

  @override
  List<Object?> get props => [
    login,
    password,
    confirmPassword,
    isButtonEnabled,
  ];
}

class RegistrationInitial extends RegistrationState {
  RegistrationInitial()
    : super(
        login: CommonTextFieldHandler(
          value: "",
          label: "Логин",
          placeholder: "Введите логин",
          message: "Начните вводить логин",
        ),
        password: CommonTextFieldHandler(
          value: "",
          label: "Пароль",
          placeholder: "Введите пароль",
          message: "Начните вводить пароль",
        ),
        confirmPassword: CommonTextFieldHandler(
          value: "",
          label: "Повторите пароль",
          placeholder: "Введите пароль",
          message: "Начните вводить пароль",
        ),
        isButtonEnabled: false,
      );
}

class RegistrationLoading extends RegistrationState {
  const RegistrationLoading({
    super.login,
    super.password,
    super.confirmPassword,
  }) : super(isButtonEnabled: false);
}

class RegistrationContent extends RegistrationState {
  const RegistrationContent();
}

class RegistrationError extends RegistrationState {
  final String message;

  const RegistrationError(
    this.message, {
    super.login,
    super.password,
    super.confirmPassword,
  }) : super(isButtonEnabled: false);

  @override
  List<Object?> get props => [
    message,
    login,
    password,
    confirmPassword,
    isButtonEnabled,
  ];

  @override
  String toString() => 'RegistrationError: $message';
}
