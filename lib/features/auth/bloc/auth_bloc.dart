import 'package:event_app/core/model/result.dart';
import 'package:event_app/core/network/network_service.dart';
import 'package:event_app/features/auth/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<RegistrationButtonPressed>(_toRegistrationScreen);
  }

  final AuthRepository _repository = AuthRepository(networkService: NetworkService());

  void _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await _repository.sendAuth(event.login, event.password);
    switch (result) {
      case Success(value: final authResponse):
        // emit(AuthSuccess());
        print(authResponse);
      case Failure(exception: final exception):
       emit(AuthError(exception.toString()));
    }
  }

  void _toRegistrationScreen(
    RegistrationButtonPressed event,
    Emitter<AuthState> emit,
  ) {
    // Просто меняем состояние (навигацию обработаем в UI)
    emit(AuthInitial());
  }
}