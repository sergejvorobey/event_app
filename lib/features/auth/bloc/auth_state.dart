part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final CommonTextFieldHandle? login;
  final CommonTextFieldHandle? password;

  const AuthState({this.login, this.password});

  AuthState copyWith({
    CommonTextFieldHandle? login,
    CommonTextFieldHandle? password,
  }) {
    return AuthState(
      login: login ?? this.login,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [login, password];
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
      );
}

class AuthLoading extends AuthState {
  const AuthLoading({super.login, super.password});
}

class AuthSuccess extends AuthState {
  const AuthSuccess({super.login, super.password});
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message, {super.login, super.password});

  @override
  List<Object?> get props => [message, login, password];

  @override
  String toString() => 'AuthError: $message';
}