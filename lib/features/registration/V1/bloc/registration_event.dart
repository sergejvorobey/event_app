part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}

class LoginChanged extends RegistrationEvent {
  final String login;
  const LoginChanged(this.login);

  @override
  List<Object?> get props => [login];
}

class PasswordChanged extends RegistrationEvent {
  final String password;
  const PasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class ConfirmPasswordChanged extends RegistrationEvent {
  final String password;
  const ConfirmPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class RegistrationButtonPressed extends RegistrationEvent {
  final String login;
  final String password;

  const RegistrationButtonPressed({
    required this.login,
    required this.password,
  });

  @override
  List<Object> get props => [login, password];
}

class FetchToken extends RegistrationEvent {
  final String userId;

  const FetchToken({required this.userId});

  @override
  List<Object?> get props => [userId];
}
