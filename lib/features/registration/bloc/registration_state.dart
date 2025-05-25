part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  // MARK: - Property

  final CommonTextFieldHandle? login;
  final CommonTextFieldHandle? password;
  final CommonTextFieldHandle? confirmPassword;
  final bool isButtonEnabled;

  const RegistrationState({
    this.login,
    this.password,
    this.confirmPassword,
    this.isButtonEnabled = false,
  });

  RegistrationState copyWith({
    CommonTextFieldHandle? login,
    CommonTextFieldHandle? password,
    CommonTextFieldHandle? confirmPassword,
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
        login: CommonTextFieldHandle(
          value: "",
          label: "Логин",
          placeholder: "Введите логин",
          message: "Начните вводить логин",
        ),
        password: CommonTextFieldHandle(
          value: "",
          label: "Пароль",
          placeholder: "Введите пароль",
          message: "Начните вводить пароль",
        ),
        confirmPassword: CommonTextFieldHandle(
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

class RegistrationSuccess extends RegistrationState {
  final String userId;

  const RegistrationSuccess({
    required this.userId,
    super.login,
    super.password,
    super.confirmPassword,
  }) : super(isButtonEnabled: false);
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

class TokenSuccess extends RegistrationState {
  const TokenSuccess({
    super.login,
    super.password,
    super.confirmPassword,
  }) : super(isButtonEnabled: false);
}

class TokenError extends RegistrationState {
  final String message;

  const TokenError(
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
  String toString() => 'TokenError: $message';
}