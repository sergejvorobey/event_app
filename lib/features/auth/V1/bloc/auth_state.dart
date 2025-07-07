part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final CommonTextFieldHandler? login;
  final CommonTextFieldHandler? password;
  final bool isButtonEnabled;

  const AuthState({this.login, this.password, this.isButtonEnabled = true});

  AuthState copyWith({
    CommonTextFieldHandler? login,
    CommonTextFieldHandler? password,
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

class AuthLoading extends AuthState {
  const AuthLoading({super.login, super.password})
    : super(isButtonEnabled: false);
}

class AuthSuccess extends AuthState {
  final String userId;

  const AuthSuccess({required this.userId, super.login, super.password})
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

class TokenSuccess extends AuthState {
  const TokenSuccess({super.login, super.password})
    : super(isButtonEnabled: false);
}

class TokenError extends AuthState {
  final String message;

  const TokenError(this.message, {super.login, super.password})
    : super(isButtonEnabled: false);

  @override
  List<Object?> get props => [message, login, password, isButtonEnabled];

  @override
  String toString() => 'TokenError: $message';
}
