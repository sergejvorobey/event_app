part of 'resume_bloc.dart';

enum ContactType { phone, email, telegram, max }

abstract class ResumeEvent extends Equatable {
  const ResumeEvent();

  @override
  List<Object> get props => [];
}

class SaveButtonPressed extends ResumeEvent {
  final String firstName;
  final String lastName;

  const SaveButtonPressed({required this.firstName, required this.lastName});

  @override
  List<Object> get props => [firstName, lastName];
}

class FetchProfile extends ResumeEvent {
  @override
  List<Object> get props => [];
}

class FirstNameChanged extends ResumeEvent {
  final String firstName;
  const FirstNameChanged(this.firstName);

  @override
  List<Object> get props => [firstName];
}

class LastNameChanged extends ResumeEvent {
  final String lastName;
  const LastNameChanged(this.lastName);

  @override
  List<Object> get props => [lastName];
}

class NavigateToEditProfileScreen extends ResumeEvent {
  @override
  List<Object> get props => [];
}

class NavigateToContactsScreen extends ResumeEvent {
  @override
  List<Object> get props => [];
}
