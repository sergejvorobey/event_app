part of 'launch_bloc.dart';

class LaunchState extends Equatable {
  const LaunchState();

  @override
  List<Object?> get props => [];
}

class LaunchInitial extends LaunchState {
  final List<LaunchPage> pages;

  const LaunchInitial({required this.pages});

  LaunchInitial copyWith({
    List<LaunchPage>? pages
  }) {
    return LaunchInitial(
      pages: pages ?? this.pages
    );
  }

  @override
  List<Object> get props => [pages];
}

class NavigateToLoginScreen extends LaunchState {}

class NavigateToRegistrationScreen extends LaunchState {}
