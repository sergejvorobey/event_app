import 'package:app_settings/app_settings.dart';
import 'package:event_app/core/model/result.dart';
import 'package:event_app/core/storage/storage_service.dart';
import 'package:event_app/features/menu/settings/repository/settings_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<LoadNotificationStatus>(_onLoadNotificationStatus);
    on<ToggleNotifications>(_onToggleNotifications);
    on<LogOutButtonPressed>(_onLogOutButtonPressed);
  }

  final SettingsRepository _repository = SettingsRepository(
    storageService: StorageService(),
  );

  Future<void> _onLoadNotificationStatus(
    SettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final bool isEnabled = await _repository.getNotificationStatus();
    emit(SettingsLoaded(notificationsEnabled: isEnabled));
  }

  void _onToggleNotifications(
    ToggleNotifications event,
    Emitter<SettingsState> emit,
  ) {
    emit(SettingsLoaded(notificationsEnabled: event.enabled));
    AppSettings.openAppSettings(type: AppSettingsType.notification);
  }

  void _onLogOutButtonPressed(
    SettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final result = await _repository.logOutProfile();
    switch (result) {
      case Success():
        emit(SettingsSuccess());
      case Failure(exception: final exception):
        emit(SettingsError(exception.toString()));
    }
  }
}
