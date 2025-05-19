part of 'launch_bloc.dart';

abstract class LaunchEvent extends Equatable {
  const LaunchEvent();
}

class LaunchContent extends LaunchEvent {
  @override
  List<Object> get props => [];
}

class LaunchPageChanged extends LaunchEvent {
  final int pageIndex;
  const LaunchPageChanged(this.pageIndex);

  @override
  List<Object?> get props => [pageIndex];
}

class LoginButtonPressed extends LaunchEvent {
  @override
  List<Object> get props => [];
}

class RegistrationButtonPressed extends LaunchEvent {
  @override
  List<Object> get props => [];
}
