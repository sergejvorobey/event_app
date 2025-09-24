part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginChanged extends LoginEvent {
  final String login;
  const LoginChanged(this.login);

  @override
  List<Object?> get props => [login];
}

class PasswordChanged extends LoginEvent {
  final String password;
  const PasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class LoginButtonPressed extends LoginEvent {
  final String login;
  final String password;

  const LoginButtonPressed({required this.login, required this.password});

  @override
  List<Object> get props => [login, password];
}

class RecoverButtonPressed extends LoginEvent {
  @override
  List<Object> get props => [];
}
