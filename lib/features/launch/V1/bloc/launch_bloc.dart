import 'package:event_app/core/model/result.dart';
import 'package:event_app/core/network/network_sevice_v2.dart';
import 'package:event_app/features/launch/V1/model/launch_page.dart';
import 'package:event_app/features/launch/V1/repository/launch_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'launch_event.dart';
part 'launch_state.dart';

class LaunchBloc extends Bloc<LaunchEvent, LaunchState> {
  LaunchBloc() : super(LaunchInitial(pages: [])) {
    on<LaunchContent>(_handleContent);
    on<LoginButtonPressed>(_handleLoginButtonPressed);
    on<RegistrationButtonPressed>(_handleRegistrationButtonPressed);
  }

  final LaunchRepository _repository = LaunchRepository(
    networkService: NetworkServiceV2(),
  );

  void _handleContent(LaunchContent event, Emitter<LaunchState> emit) async {
    emit(LaunchLoading());
    final result = await _repository.fetchContent();

    switch (result) {
      case Success():
        emit(NavigateToHomeScreen());
      case Failure():
        emit(
          LaunchInitial(
            pages: [
              LaunchPage(
                icon: 'assets/icons/hand.wave.fill.png',
                title: "Начните искать и зарабатывать",
                text:
                    "Находите краткосрочные вакансии и публикуйте свои услуги для мероприятий. В нашем приложении вы можете быстро найти работу по своим талантам и навыкам",
                onboarding:
                    "Находите краткосрочные вакансии и публикуйте свои услуги для мероприятий",
              ),
              LaunchPage(
                icon: 'assets/icons/magnifyingglass.png',
                title: "Легкий поиск вакансий",
                text:
                    "Просматривайте вакансии по категориям или используйте поиск для точного нахождения подходящей работы. Будь вы певец, фотограф или организатор, мы поможем вам найти идеальную работу",
                onboarding:
                    "Просматривайте вакансии по категориям или используйте поиск для точного нахождения подходящей работы",
              ),
              LaunchPage(
                icon: 'assets/icons/megaphone.fill.png',
                title: "Публикуйте свои услуги",
                text:
                    "Организовываете мероприятие? Публикуйте вакансии за считанные минуты. Опишите детали, установите бюджет, и найдите профессионалов для вашего события",
                onboarding:
                    "Организовываете мероприятие? Публикуйте вакансии за считанные минуты",
              ),
            ],
          ),
        );
    }
  }

  void _handleLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LaunchState> emit,
  ) {
    emit(NavigateToLoginScreen());
  }

  void _handleRegistrationButtonPressed(
    RegistrationButtonPressed event,
    Emitter<LaunchState> emit,
  ) {
    emit(NavigateToRegistrationScreen());
  }
}
