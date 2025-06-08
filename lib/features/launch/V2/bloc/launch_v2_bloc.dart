import 'package:event_app/core/model/result.dart';
import 'package:event_app/core/network/network_service.dart';
import 'package:event_app/core/storage/storage_service.dart';
import 'package:event_app/features/launch/V1/model/launch_page.dart';
import 'package:event_app/features/launch/V2/repository/launch_v2_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'launch_v2_event.dart';
part 'launch_v2_state.dart';

class LaunchV2Bloc extends Bloc<LaunchV2Event, LaunchV2State> {
  LaunchV2Bloc() : super(LaunchV2Initial(pages: [])) {
    on<LaunchV2Content>(_handleContent);
    on<LoginButtonPressed>(_handleLoginButtonPressed);
    on<RegistrationButtonPressed>(_handleRegistrationButtonPressed);
  }

  final LaunchV2Repository _repository = LaunchV2Repository(
    networkService: NetworkService(),
    storageService: StorageService()
  );

  void _handleContent(
    LaunchV2Content event,
    Emitter<LaunchV2State> emit,
  ) async {
    emit(LaunchV2Loading());
    final result = await _repository.fetchToken();

    switch (result) {
      case Success():
        emit(NavigateToHomeScreen());
      case Failure():
        emit(
          LaunchV2Initial(
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
    Emitter<LaunchV2State> emit,
  ) {
    emit(NavigateToLoginScreen());
  }

  void _handleRegistrationButtonPressed(
    RegistrationButtonPressed event,
    Emitter<LaunchV2State> emit,
  ) {
    emit(NavigateToRegistrationScreen());
  }
}
