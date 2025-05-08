import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<NavigateToRegistration>(_onNavigateToRegistration);
  }

  void _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // Здесь будет вызов API для авторизации
      await Future.delayed(const Duration(seconds: 1)); // Заглушка
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError('Ошибка входа: ${e.toString()}'));
    }
  }

  void _onNavigateToRegistration(
    NavigateToRegistration event,
    Emitter<AuthState> emit,
  ) {
    // Просто меняем состояние (навигацию обработаем в UI)
    emit(AuthInitial());
  }
}