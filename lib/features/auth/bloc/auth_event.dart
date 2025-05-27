part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginChanged extends AuthEvent {
  final String login;
  const LoginChanged(this.login);

  @override
  List<Object?> get props => [login];
}

class PasswordChanged extends AuthEvent {
  final String password;
  const PasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class LoginButtonPressed extends AuthEvent {
  final String login;
  final String password;

  const LoginButtonPressed({required this.login, required this.password});

  @override
  List<Object> get props => [login, password];
}

class RecoverButtonPressed extends AuthEvent {
  @override
  List<Object> get props => [];
}

class FetchToken extends AuthEvent {
  final String userId;

  const FetchToken({required this.userId});

  @override
  List<Object?> get props => [userId];
}