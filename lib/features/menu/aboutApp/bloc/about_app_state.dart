part of 'about_app_bloc.dart';

abstract class AboutAppState extends Equatable {
  const AboutAppState();

  @override
  List<Object?> get props => [];
}

class AboutAppInitial extends AboutAppState {}

class AboutAppLoading extends AboutAppState {}

class AboutAppLoaded extends AboutAppState {
  final String appName;
  final String appDescription;
  final String version;
  final String buildNumber;
  final String developer;
  final String copyright;

  const AboutAppLoaded({
    required this.appName,
    required this.appDescription,
    required this.version,
    required this.buildNumber,
    required this.developer,
    required this.copyright,
  });

  @override
  List<Object?> get props => [
    appName,
    appDescription,
    version,
    buildNumber,
    developer,
    copyright,
  ];
}

class AboutAppFeedbackSent extends AboutAppState {
  final String message;

  const AboutAppFeedbackSent(this.message);

  @override
  List<Object?> get props => [message];
}

class AboutAppError extends AboutAppState {
  final String message;

  const AboutAppError(this.message);

  @override
  List<Object?> get props => [message];
}
