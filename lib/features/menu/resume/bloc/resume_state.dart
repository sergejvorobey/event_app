part of 'resume_bloc.dart';

abstract class ResumeState extends Equatable {
  final ResumeContent? content;
  
  const ResumeState({this.content});
  
  @override
  List<Object?> get props => [content];
}

class ResumeInitial extends ResumeState {
  const ResumeInitial() : super(content: null);
}

class ResumeLoading extends ResumeState {
  const ResumeLoading() : super(content: null);
}

class ResumeError extends ResumeState {
  final String title;
  final String subtitle;
  final String actionTitle;

  const ResumeError({
    required this.title,
    required this.subtitle,
    required this.actionTitle,
  });

  @override
  List<Object> get props => [title, subtitle, actionTitle];
}

class ResumeNotification extends ResumeState {
  final String title;
  final String message;
  final ToastType type;

  const ResumeNotification({
    required this.title,
    required this.message,
    required this.type,
  });

  @override
  List<Object> get props => [title, message, type];
}

class ResumeContent extends ResumeState {
  final CommonTextFieldHandler login;
  final CommonTextFieldHandler city;

  // ФИО
  final CommonTextFieldHandler firstName;
  final CommonTextFieldHandler lastName;

  // Статус
  // final CommonTextFieldHandler status;

  // Контакты
  final CommonTextFieldHandler phoneNumber;
  final CommonTextFieldHandler email;
  final CommonTextFieldHandler telegram;
  final CommonTextFieldHandler max;

  // Профессия
  final CommonTextFieldHandler profession;

  final CommonButtonHandler saveButton;

  const ResumeContent({
    required this.login,
    required this.city,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.telegram,
    required this.max,
    required this.profession,
    required this.saveButton,
  });

  ResumeContent copyWith({
    CommonTextFieldHandler? login,
    CommonTextFieldHandler? city,
    CommonTextFieldHandler? firstName,
    CommonTextFieldHandler? lastName,
    CommonTextFieldHandler? phoneNumber,
    CommonTextFieldHandler? email,
    CommonTextFieldHandler? telegram,
    CommonTextFieldHandler? max,
    CommonTextFieldHandler? profession,
    bool? isStartActivityIndicator,
  }) {
    final updatedLogin = login ?? this.login;
    final updatedCity = city ?? this.city;
    final updatedFirstName = firstName ?? this.firstName;
    final updatedLastName = lastName ?? this.lastName;
    final updatedPhoneNumber = phoneNumber ?? this.phoneNumber;
    final updatedEmail = email ?? this.email;
    final updatedTelegram = telegram ?? this.telegram;
    final updatedMax = max ?? this.max;
    final updatedProfession = profession ?? this.profession;

    final isFormValid =
        updatedFirstName.message.isEmpty &&
        updatedLastName.message.isEmpty &&
        updatedPhoneNumber.message.isEmpty &&
        updatedEmail.message.isEmpty &&
        updatedTelegram.message.isEmpty &&
        updatedMax.message.isEmpty &&
        updatedProfession.message.isEmpty;

    final activityIndicator =
        isStartActivityIndicator ?? saveButton.isStartActivityIndicator;

    return ResumeContent(
      login: updatedLogin,
      city: updatedCity,
      firstName: updatedFirstName,
      lastName: updatedLastName,
      phoneNumber: updatedPhoneNumber,
      email: updatedEmail,
      telegram: updatedTelegram,
      max: updatedMax,
      profession: updatedProfession,
      saveButton: CommonButtonHandler(
        title: saveButton.title,
        isEnabled: activityIndicator ? false : isFormValid,
        isStartActivityIndicator:
            isStartActivityIndicator ?? saveButton.isStartActivityIndicator,
      ),
    );
  }

  @override
  List<Object> get props => [
    login,
    city,
    firstName,
    lastName,
    phoneNumber,
    email,
    telegram,
    max,
    profession,
    saveButton,
  ];
}

class ShowEditProfileScreen extends ResumeState {
  @override
  List<Object> get props => [];
}

class ShowContactsScreen extends ResumeState {
  @override
  List<Object> get props => [];
}

class ShowModalPopupScreen extends ResumeState {
  final CommonTextFieldHandler textField;
  
  const ShowModalPopupScreen({
    required ResumeContent content,
    required this.textField,
  }) : super(content: content);
  
  @override
  List<Object?> get props => [...super.props, textField];
}

// class ShowModalPopupScreen extends ResumeState {
//   final CommonTextFieldHandler textField;

//   const ShowModalPopupScreen({
//     required this.textField,
//   });

//   @override
//   List<Object> get props => [textField];
// }


// class ResumeModalState extends ResumeState {
//   final ResumeContent content;
//   final CommonTextFieldHandler textField;

//   const ResumeModalState({required this.content, required this.textField});

//   @override
//   List<Object> get props => [content, textField];
// }
