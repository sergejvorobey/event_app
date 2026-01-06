part of 'editprofile_bloc.dart';

abstract class EditprofileState extends Equatable {
  const EditprofileState();

  @override
  List<Object?> get props => [];
}

class EditprofileContent extends EditprofileState {
  final CommonTextFieldHandler firstName;
  final CommonTextFieldHandler lastName;
  final CommonTextFieldHandler birthday;
  final CommonTextFieldHandler city;

  // Контакты
  final CommonTextFieldHandler phone;
  final CommonTextFieldHandler telegram;
  final CommonTextFieldHandler max;

  final CommonButtonHandler saveButton;

  const EditprofileContent({
    required this.firstName,
    required this.lastName,
    required this.birthday,
    required this.city,
    required this.phone,
    required this.telegram,
    required this.max,
    required this.saveButton,
  });

  EditprofileContent copyWith({
    CommonTextFieldHandler? firstName,
    CommonTextFieldHandler? lastName,
    CommonTextFieldHandler? birthday,
    CommonTextFieldHandler? city,
    CommonTextFieldHandler? phone,
    CommonTextFieldHandler? telegram,
    CommonTextFieldHandler? max,
    bool? isStartActivityIndicator,
  }) {
    final updatedFirstName = firstName ?? this.firstName;
    final updatedLastName = lastName ?? this.lastName;
    final updatedBirthday = birthday ?? this.birthday;
    final updatedCity = city ?? this.city;
    final updatedPhone = phone ?? this.phone;
    final updatedTelegram = telegram ?? this.telegram;
    final updatedMax = max ?? this.max;

    final isFormValid =
        updatedFirstName.message.isEmpty && updatedLastName.message.isEmpty;

    final activityIndicator =
        isStartActivityIndicator ?? saveButton.isStartActivityIndicator;

    return EditprofileContent(
      firstName: updatedFirstName,
      lastName: updatedLastName,
      birthday: updatedBirthday,
      city: updatedCity,
      phone: updatedPhone,
      telegram: updatedTelegram,
      max: updatedMax,
      saveButton: CommonButtonHandler(
        title: saveButton.title,
        isEnabled: activityIndicator ? false : isFormValid,
        isStartActivityIndicator:
            isStartActivityIndicator ?? saveButton.isStartActivityIndicator,
      ),
    );
  }

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    saveButton,
    city,
    phone,
    telegram,
    max,
  ];
}

class EditprofileInitial extends EditprofileState {
  const EditprofileInitial();
}

class EditprofileLoading extends EditprofileState {
  const EditprofileLoading();
}

class EditprofileSendRequest extends EditprofileState {
  const EditprofileSendRequest();
}

class EditprofileError extends EditprofileState {
  final String title;
  final String subtitle;
  final String actionTitle;

  const EditprofileError({
    required this.title,
    required this.subtitle,
    required this.actionTitle,
  });

  @override
  List<Object?> get props => [title, subtitle, actionTitle];
}

class EditprofileNotification extends EditprofileState {
  final String title;
  final String message;
  final ToastType type;

  const EditprofileNotification({
    required this.title,
    required this.message,
    required this.type,
  });

  @override
  List<Object?> get props => [title, message, type];
}

class ShowEmptyStateScreen extends EditprofileState {
  final String title;
  final String subtitle;
  final String actionTitle;

  const ShowEmptyStateScreen({
    required this.title,
    required this.subtitle,
    required this.actionTitle,
  });

  @override
  List<Object?> get props => [title, subtitle, actionTitle];
}
