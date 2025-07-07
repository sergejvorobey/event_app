part of 'editprofile_bloc.dart';

abstract class EditprofileState extends Equatable {
  const EditprofileState();

  @override
  List<Object?> get props => [];
}

class EditprofileContent extends EditprofileState {
  final CommonTextFieldHandler firstName;
  final CommonTextFieldHandler lastName;
  final CommonTextFieldHandler email;
  final CommonTextFieldHandler city;
  final CommonButtonHandler saveButton;

  const EditprofileContent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.city,
    required this.saveButton,
  });

  EditprofileContent copyWith({
    CommonTextFieldHandler? firstName,
    CommonTextFieldHandler? lastName,
    CommonTextFieldHandler? email,
    CommonTextFieldHandler? city,
    bool? isStartActivityIndicator,
  }) {
    final updatedFirstName = firstName ?? this.firstName;
    final updatedLastName = lastName ?? this.lastName;
    final updatedEmail = email ?? this.email;
    final updatedCity = city ?? this.city;

    final isFormValid =
        updatedFirstName.message.isEmpty &&
        updatedLastName.message.isEmpty &&
        updatedEmail.message.isEmpty;

    final activityIndicator = isStartActivityIndicator ?? saveButton.isStartActivityIndicator;

    return EditprofileContent(
      firstName: updatedFirstName,
      lastName: updatedLastName,
      email: updatedEmail,
      city: updatedCity,
      saveButton: CommonButtonHandler(
        title: saveButton.title,
        isEnabled: activityIndicator ? false : isFormValid,
        isStartActivityIndicator: isStartActivityIndicator ?? saveButton.isStartActivityIndicator,
      ),
    );
  }

  @override
  List<Object?> get props => [firstName, lastName, email, saveButton];
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
    required this.type
  });

  @override
  List<Object?> get props => [title, message, type];
}