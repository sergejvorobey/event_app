part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class LoadNotificationStatus extends SettingsEvent {
  const LoadNotificationStatus();

  @override
  List<Object> get props => [];
}

class ToggleNotifications extends SettingsEvent {
  final bool enabled;
  const ToggleNotifications(this.enabled);

  @override
  List<Object> get props => [enabled];
}

class LogOutButtonPressed extends SettingsEvent {
  const LogOutButtonPressed();

  @override
  List<Object> get props => [];
}
