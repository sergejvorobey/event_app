part of 'about_app_bloc.dart';

abstract class AboutAppEvent extends Equatable {
  const AboutAppEvent();

  @override
  List<Object?> get props => [];
}

class LoadAppInfo extends AboutAppEvent {
  const LoadAppInfo();
}

class SendFeedback extends AboutAppEvent {
  const SendFeedback();
}

