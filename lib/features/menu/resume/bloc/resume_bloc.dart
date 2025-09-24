import 'package:event_app/core/model/result.dart';
import 'package:event_app/core/validation/input_validators.dart';
import 'package:event_app/features/menu/resume/repository/resume_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/core/ui/common_button_handler.dart';
import 'package:event_app/core/ui/common_text_field_handler.dart';
import 'package:event_app/core/ui/widgets/common_top_toast_widget.dart';

part 'resume_event.dart';
part 'resume_state.dart';

class ResumeBloc extends Bloc<ResumeEvent, ResumeState> {
  ResumeBloc() : super(ResumeInitial()) {
    on<FetchProfile>(_handleFetchProfile);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<NavigateToEditProfileScreen>(_navigateToEditProfileScreen);
    on<NavigateToContactsScreen>(_handleContactPressed);
  }

  final ResumeRepository _resumeRepository = ResumeRepository();

  void _handleFetchProfile(
    FetchProfile event,
    Emitter<ResumeState> emit,
  ) async {
    emit(ResumeLoading());

    final result = await _resumeRepository.fetchProfile();
    switch (result) {
      case Success(value: final profileResponse):
        emit(
          ResumeContent(
            login: CommonTextFieldHandler(
              value: profileResponse.login,
              label: "",
              placeholder: "",
              message: "",
            ),
            city: CommonTextFieldHandler(
              value:
                  profileResponse.city.isEmpty
                      ? "Город не указан"
                      : profileResponse.city,
              label: "",
              placeholder: "",
              message: "",
            ),
            firstName: CommonTextFieldHandler(
              value: profileResponse.firstName,
              label: "Имя",
              placeholder: "Введите имя",
              message: validateFirstName(profileResponse.firstName),
            ),
            lastName: CommonTextFieldHandler(
              value: profileResponse.lastName,
              label: "Фамилия",
              placeholder: "Введите фамилию",
              message: validateLastName(profileResponse.lastName),
            ),
            phoneNumber: CommonTextFieldHandler(
              value:
                  profileResponse.phoneNumber.isEmpty
                      ? "Не указан"
                      : profileResponse.phoneNumber,
              label: "Номер телефона",
              placeholder: "Введите номер телефона",
              message: validatePhoneNumber(profileResponse.phoneNumber),
            ),
            email: CommonTextFieldHandler(
              value:
                  profileResponse.email.isEmpty
                      ? "Не указано"
                      : profileResponse.email,
              label: "Почта",
              placeholder: "Введите почту",
              message: validateEmail(profileResponse.email),
            ),
            telegram: CommonTextFieldHandler(
              value: "Не указано", // profileResponse.telegram,
              label: "Telegram",
              placeholder: "Введите никнейм telegram",
              message: validateTelegramUsername(""), // profileResponse.telegram
            ),
            max: CommonTextFieldHandler(
              value: "Не указано", // profileResponse.telegram,
              label: "MAX",
              placeholder: "Введите никнейм max",
              message: validateTelegramUsername(""), // profileResponse.max
            ),
            profession: CommonTextFieldHandler(
              value: "", // profileResponse.profession,
              label: "Профессия",
              placeholder: "Выберите профессию",
              message: validateProfession(""), // profileResponse.profession
            ),
            saveButton: CommonButtonHandler(
              title: "Сохранить",
              isEnabled: false,
              isStartActivityIndicator: false,
            ),
          ),
        );
      case Failure():
        emit(
          ResumeError(
            title: "Ошибка",
            subtitle: "Что-то пошло не так, попробуйте еще раз",
            actionTitle: "Обновить",
          ),
        );
    }
  }

  void _onFirstNameChanged(FirstNameChanged event, Emitter<ResumeState> emit) {
    // Обрабатываем только если текущее состояние — ResumeContent
    final currentState = state;
    if (currentState is! ResumeContent) return;

    final updatedFirstName = currentState.firstName.copyWith(
      value: event.firstName,
      message: validateFirstName(event.firstName),
    );

    emit(currentState.copyWith(firstName: updatedFirstName));
  }

  void _onLastNameChanged(LastNameChanged event, Emitter<ResumeState> emit) {
    // Обрабатываем только если текущее состояние — ResumeContent
    final currentState = state;
    if (currentState is! ResumeContent) return;

    final updatedLastName = currentState.lastName.copyWith(
      value: event.lastName,
      message: validateLastName(event.lastName),
    );

    emit(currentState.copyWith(lastName: updatedLastName));
  }

  void _navigateToEditProfileScreen(
    NavigateToEditProfileScreen event,
    Emitter<ResumeState> emit,
  ) {
    emit(ShowEditProfileScreen());
  }

  void _handleContactPressed(
    NavigateToContactsScreen event,
    Emitter<ResumeState> emit,
  ) {
    emit(ShowContactsScreen());

    // final currentState = state;
    // if (currentState is! ResumeContent) return;

    // switch (event.type) {
    //   case ContactType.phone:
    //     emit(
    //       ShowModalPopupScreen(
    //         textField: CommonTextFieldHandler(
    //           value: "",
    //           label: "Номер телефона",
    //           placeholder: "+7 (000) 000 00 00",
    //           message: "Начните вводить телефон",
    //         ),
    //         content: currentState,
    //       ),
    //     );
    //   case ContactType.email:
    //     emit(
    //       ShowModalPopupScreen(
    //         textField: CommonTextFieldHandler(
    //           value: "",
    //           label: "Почта",
    //           placeholder: "Почта",
    //           message: "Начните вводить почту",
    //         ),
    //         content: currentState,
    //       ),
    //     );
    //   case ContactType.telegram:
    //     emit(
    //       ShowModalPopupScreen(
    //         textField: CommonTextFieldHandler(
    //           value: "",
    //           label: "Telegram",
    //           placeholder: "@имя",
    //           message: "Начните вводить telegram",
    //         ),
    //         content: currentState,
    //       ),
    //     );
    //     case ContactType.max:
    //     emit(
    //       ShowModalPopupScreen(
    //         textField: CommonTextFieldHandler(
    //           value: "",
    //           label: "MAX",
    //           placeholder: "@имя",
    //           message: "Начните вводить max",
    //         ),
    //         content: currentState,
    //       ),
    //     );
    // }
  }
}
