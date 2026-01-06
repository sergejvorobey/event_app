import 'package:equatable/equatable.dart';
import 'package:event_app/core/model/result.dart';
import 'package:event_app/core/ui/common_button_handler.dart';
import 'package:event_app/core/ui/common_text_field_handler.dart';
import 'package:event_app/core/ui/widgets/common_top_toast_widget.dart';
import 'package:event_app/core/validation/input_validators.dart';
import 'package:event_app/features/user/editProfile/repository/editprofile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'editprofile_event.dart';
part 'editprofile_state.dart';

class EditprofileBloc extends Bloc<EditprofileEvent, EditprofileState> {
  EditprofileBloc() : super(EditprofileInitial()) {
    on<FetchProfile>(_handleFetchProfile);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<CityChanged>(_onCityChanged);
    on<SaveButtonPressed>(_onSaveButtonPressed);
  }

  final EditprofileRepository _editprofileRepository = EditprofileRepository();

  void _handleFetchProfile(
    FetchProfile event,
    Emitter<EditprofileState> emit,
  ) async {
    emit(EditprofileLoading());

    final result = await _editprofileRepository.fetchProfile();
    switch (result) {
      case Success(value: final profileResponse):
        emit(
          EditprofileContent(
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
            birthday: CommonTextFieldHandler(
              value: profileResponse.birthday,
              label: "Дата рождения",
              placeholder: "Введите дату рождения",
              message: validateBirthday(profileResponse.birthday),
            ),
            city: CommonTextFieldHandler(
              value: profileResponse.location,
              label: "Город",
              placeholder: "Введите город",
              message: validateCity(profileResponse.location),
            ),
            phone: CommonTextFieldHandler(
              value: profileResponse.phone,
              label: "Телефон",
              placeholder: "Введите телефон",
              message: validatePhoneNumber(profileResponse.phone),
            ),
            telegram: CommonTextFieldHandler(
              value: profileResponse.telegramUrl,
              label: "Telegram",
              placeholder: "Введите telegram",
              message: validateTelegramUsername(profileResponse.telegramUrl),
            ),
            max: CommonTextFieldHandler(
              value: profileResponse.maxUrl,
              label: "MAX",
              placeholder: "Введите MAX",
              message: validateMaxUsername(profileResponse.maxUrl),
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
          ShowEmptyStateScreen(
            title: "Ошибка",
            subtitle: "Что-то пошло не так, попробуйте еще раз",
            actionTitle: "Обновить",
          ),
        );
    }
  }

  void _onFirstNameChanged(
    FirstNameChanged event,
    Emitter<EditprofileState> emit,
  ) {
    // Обрабатываем только если текущее состояние — EditprofileContent
    final currentState = state;
    if (currentState is! EditprofileContent) return;

    final updatedFirstName = currentState.firstName.copyWith(
      value: event.firstName,
      message: validateFirstName(event.firstName),
    );

    emit(currentState.copyWith(firstName: updatedFirstName));
  }

  void _onLastNameChanged(
    LastNameChanged event,
    Emitter<EditprofileState> emit,
  ) {
    // Обрабатываем только если текущее состояние — EditprofileContent
    final currentState = state;
    if (currentState is! EditprofileContent) return;

    final updatedLastName = currentState.lastName.copyWith(
      value: event.lastName,
      message: validateLastName(event.lastName),
    );

    emit(currentState.copyWith(lastName: updatedLastName));
  }

  void _onEmailChanged(EmailChanged event, Emitter<EditprofileState> emit) {
    // Обрабатываем только если текущее состояние — EditprofileContent
    final currentState = state;
    if (currentState is! EditprofileContent) return;

    // final updatedEmail = currentState.email.copyWith(
    //   value: event.email,
    //   message: validateEmail(event.email),
    // );

    // emit(currentState.copyWith(email: updatedEmail));
  }

  void _onSaveButtonPressed(
    SaveButtonPressed event,
    Emitter<EditprofileState> emit,
  ) async {
    final currentState = state;
    if (currentState is! EditprofileContent) return;
    emit(currentState.copyWith(isStartActivityIndicator: true));

    final result = await _editprofileRepository.updateProfile(
      currentState.firstName.value,
      currentState.lastName.value,
      "",
      "",
      // currentState.city.value,
      // currentState.email.value,
    );

    switch (result) {
      case Success(value: final _):
        emit(
          EditprofileNotification(
            type: ToastType.success,
            title: "Успешно!",
            message: "Профиль был обновлен",
          ),
        );
        emit(currentState.copyWith(isStartActivityIndicator: false));
        break;
      case Failure():
        emit(
          EditprofileNotification(
            type: ToastType.error,
            title: "Ошибка",
            message: "Что-то пошло не так, попробуйте еще раз",
          ),
        );
        emit(currentState.copyWith(isStartActivityIndicator: false));
        break;
    }
  }

  void _onCityChanged(CityChanged event, Emitter<EditprofileState> emit) {
    final currentState = state;
    if (currentState is! EditprofileContent) return;

    // final updatedCity = currentState.city.copyWith(
    //   value: event.city,
    //   message: "",
    // );

    // emit(currentState.copyWith(city: updatedCity));
  }
}
