part of 'launch_v2_bloc.dart';

abstract class LaunchV2Event extends Equatable {
  const LaunchV2Event();
}

class LaunchV2Content extends LaunchV2Event {
  @override
  List<Object> get props => [];
}

class LaunchV2PageChanged extends LaunchV2Event {
  final int pageIndex;
  const LaunchV2PageChanged(this.pageIndex);

  @override
  List<Object?> get props => [pageIndex];
}

class LoginButtonPressed extends LaunchV2Event {
  @override
  List<Object> get props => [];
}

class RegistrationButtonPressed extends LaunchV2Event {
  @override
  List<Object> get props => [];
}
