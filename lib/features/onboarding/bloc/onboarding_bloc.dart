import 'package:event_app/features/onboarding/model/onboarding_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc()
      : super(const OnboardingInitial(
          currentPage: 0,
          title: 'Работа и персонал',
          subtitle: 'рядом с вами',
          description:
              'Быстрый поиск диджеев, барменов и ведущих на карте города. Находите смены или команду за пару минут.',
          imagePath: 'assets/icons/Onboarding_1.png',
        )) {
    on<NextButtonPressed>(_onNextButtonPressed);
    on<PageChanged>(_onPageChanged);
  }

  final List<OnboardingPage> pages = [
    const OnboardingPage(
      title: 'Работа и персонал',
      subtitle: 'рядом с вами',
      description:
          'Быстрый поиск диджеев, барменов и ведущих на карте города. Находите смены или команду за пару минут.',
      imagePath: 'assets/icons/Onboarding_1.png',
    ),
    const OnboardingPage(
      title: 'Для профи',
      subtitle: 'и заказчиков',
      description:
          'Управляйте календарем, получайте прямые офферы или находите персонал за 5 минут без посредников.',
      imagePath: 'assets/icons/Onboarding_2.png',
    )
  ];

  void _onNextButtonPressed(
    NextButtonPressed event,
    Emitter<OnboardingState> emit,
  ) {
    if (state is OnboardingInitial) {
      final currentState = state as OnboardingInitial;
      final currentPage = currentState.currentPage;

      if (currentPage < pages.length - 1) {
        final nextPage = currentPage + 1;
        emit(OnboardingInitial(
          currentPage: nextPage,
          title: pages[nextPage].title,
          subtitle: pages[nextPage].subtitle,
          description: pages[nextPage].description,
          imagePath: pages[nextPage].imagePath,
        ));
      } else {
        emit(const OnboardingComplete());
      }
    }
  }

  void _onPageChanged(
    PageChanged event,
    Emitter<OnboardingState> emit,
  ) {
    emit(OnboardingInitial(
      currentPage: event.pageIndex,
      title: pages[event.pageIndex].title,
      subtitle: pages[event.pageIndex].subtitle,
      description: pages[event.pageIndex].description,
      imagePath: pages[event.pageIndex].imagePath,
    ));
  }
}
