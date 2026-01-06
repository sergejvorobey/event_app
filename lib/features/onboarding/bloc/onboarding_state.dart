part of 'onboarding_bloc.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

final class OnboardingInitial extends OnboardingState {
  final int currentPage;
  final String title;
  final String subtitle;
  final String description;
  final String imagePath;

  const OnboardingInitial({
    required this.currentPage,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imagePath,
  });

  @override
  List<Object> get props => [
        currentPage,
        title,
        subtitle,
        description,
        imagePath,
      ];

  bool get isLastPage => currentPage == 1;
  bool get isFirstPage => currentPage == 0;
}

final class NavigateToLoginScreen extends OnboardingState {}

final class NavigateToRegistrationScreen extends OnboardingState {}

final class NavigateToNextScreen extends OnboardingState {}

final class OnboardingComplete extends OnboardingState {
  const OnboardingComplete();
}
