part of 'launch_v2_bloc.dart';

abstract class LaunchV2State extends Equatable {
  const LaunchV2State();
  
  @override
  List<Object> get props => [];
}

class LaunchV2Initial extends LaunchV2State {
  final List<LaunchPage> pages;

  const LaunchV2Initial({required this.pages});

  LaunchV2Initial copyWith({List<LaunchPage>? pages}) {
    return LaunchV2Initial(pages: pages ?? this.pages);
  }

  @override
  List<Object> get props => [pages];
}

class LaunchV2Loading extends LaunchV2State {
  const LaunchV2Loading();
}

class NavigateToLoginScreen extends LaunchV2State {}

class NavigateToRegistrationScreen extends LaunchV2State {}

class NavigateToHomeScreen extends LaunchV2State {}
