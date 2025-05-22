part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final CommonTextFieldHandle? login;
  final CommonTextFieldHandle? password;
  final bool isButtonEnabled;

  const AuthState({this.login, this.password, this.isButtonEnabled = true});

  AuthState copyWith({
    CommonTextFieldHandle? login,
    CommonTextFieldHandle? password,
    bool? isButtonEnabled,
  }) {
    final updatedLogin = login ?? this.login;
    final updatedPassword = password ?? this.password;

    final loginValid = updatedLogin?.message.isEmpty ?? false;
    final passwordValid = updatedPassword?.message.isEmpty ?? false;

    return AuthState(
      login: updatedLogin,
      password: updatedPassword,
      isButtonEnabled: isButtonEnabled ?? (loginValid && passwordValid),
    );
  }

  @override
  List<Object?> get props => [login, password, isButtonEnabled];
}

class AuthInitial extends AuthState {
  AuthInitial()
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
        isButtonEnabled: false,
      );
}

class AuthLoading extends AuthState {
  const AuthLoading({super.login, super.password})
    : super(isButtonEnabled: false);
}

class AuthSuccess extends AuthState {
  const AuthSuccess({super.login, super.password})
    : super(isButtonEnabled: false);
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message, {super.login, super.password})
    : super(isButtonEnabled: false);

  @override
  List<Object?> get props => [message, login, password, isButtonEnabled];

  @override
  String toString() => 'AuthError: $message';
}