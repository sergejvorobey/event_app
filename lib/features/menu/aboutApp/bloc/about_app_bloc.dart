import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'about_app_event.dart';
part 'about_app_state.dart';

class AboutAppBloc extends Bloc<AboutAppEvent, AboutAppState> {
  AboutAppBloc() : super(AboutAppInitial()) {
    on<LoadAppInfo>(_onLoadAppInfo);
    on<SendFeedback>(_onSendFeedback);
  }

  Future<void> _onLoadAppInfo(
    LoadAppInfo event,
    Emitter<AboutAppState> emit,
  ) async {
    try {
      emit(AboutAppLoading());

      final packageInfo = await PackageInfo.fromPlatform();

      emit(
        AboutAppLoaded(
          appName: 'Event App',
          appDescription: 'Приложение для организации и участия в событиях',
          version: packageInfo.version,
          buildNumber: packageInfo.buildNumber,
          developer: 'Event App Team',
          copyright: '© 2024 Event App. Все права защищены.',
        ),
      );
    } catch (e) {
      emit(AboutAppError('Не удалось загрузить информацию о приложении: $e'));
    }
  }

  Future<void> _onSendFeedback(
    SendFeedback event,
    Emitter<AboutAppState> emit,
  ) async {
    try {
      emit(AboutAppLoading());

      // TODO: Реализовать отправку обратной связи
      await Future.delayed(const Duration(seconds: 1));

      emit(AboutAppFeedbackSent('Обратная связь отправлена успешно!'));

      // Возвращаемся к загруженному состоянию
      final packageInfo = await PackageInfo.fromPlatform();
      emit(
        AboutAppLoaded(
          appName: 'Event App',
          appDescription: 'Приложение для организации и участия в событиях',
          version: packageInfo.version,
          buildNumber: packageInfo.buildNumber,
          developer: 'Event App Team',
          copyright: '© 2024 Event App. Все права защищены.',
        ),
      );
    } catch (e) {
      emit(AboutAppError('Не удалось отправить обратную связь: $e'));
    }
  }
}

