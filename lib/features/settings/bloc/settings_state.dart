part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  final bool notificationsEnabled;
  const SettingsState({this.notificationsEnabled = true});
}

class SettingsInitial extends SettingsState {
  const SettingsInitial();

  @override
  List<Object?> get props => [notificationsEnabled];
}

class SettingsLoaded extends SettingsState {
  const SettingsLoaded({required super.notificationsEnabled});

  @override
  List<Object?> get props => [notificationsEnabled];
}

class SettingsSuccess extends SettingsState {
  const SettingsSuccess();

  @override
  List<Object?> get props => [];
}

class SettingsError extends SettingsState {
  final String message;

  const SettingsError(this.message);

  @override
  List<Object?> get props => [message];
}
