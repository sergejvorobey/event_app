part of 'login_bloc.dart';

class LoginState extends Equatable {
  final CommonTextFieldHandler? login;
  final CommonTextFieldHandler? password;
  final bool isButtonEnabled;

  const LoginState({this.login, this.password, this.isButtonEnabled = true});

  LoginState copyWith({
    CommonTextFieldHandler? login,
    CommonTextFieldHandler? password,
    bool? isButtonEnabled,
  }) {
    final updatedLogin = login ?? this.login;
    final updatedPassword = password ?? this.password;

    final loginValid = updatedLogin?.message.isEmpty ?? false;
    final passwordValid = updatedPassword?.message.isEmpty ?? false;

    return LoginState(
      login: updatedLogin,
      password: updatedPassword,
      isButtonEnabled: isButtonEnabled ?? (loginValid && passwordValid),
    );
  }

  @override
  List<Object?> get props => [login, password, isButtonEnabled];
}

class LoginInitial extends LoginState {
  LoginInitial()
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
        isButtonEnabled: false,
      );
}

class LoginLoading extends LoginState {
  const LoginLoading({super.login, super.password})
    : super(isButtonEnabled: false);
}

class LoginContent extends LoginState {
  const LoginContent();
}

class LoginError extends LoginState {
  final String message;

  const LoginError(this.message, {super.login, super.password})
    : super(isButtonEnabled: false);

  @override
  List<Object?> get props => [message, login, password, isButtonEnabled];

  @override
  String toString() => 'AuthError: $message';
}
