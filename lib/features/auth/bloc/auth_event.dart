part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginButtonPressed extends AuthEvent {
  final String login;
  final String password;

  const LoginButtonPressed({required this.login, required this.password});

  @override
  List<Object> get props => [login, password];
}

class RegistrationButtonPressed extends AuthEvent {
  @override
  List<Object> get props => [];
}