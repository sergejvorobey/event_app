part of 'editprofile_bloc.dart';

abstract class EditprofileEvent extends Equatable {
  const EditprofileEvent();

  @override
  List<Object> get props => [];
}

class SaveButtonPressed extends EditprofileEvent {
  final String firstName;
  final String lastName;
  final String email;

  const SaveButtonPressed({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  List<Object> get props => [firstName, lastName, email];
}

class FetchProfile extends EditprofileEvent {
  @override
  List<Object> get props => [];
}

class FirstNameChanged extends EditprofileEvent {
  final String firstName;
  const FirstNameChanged(this.firstName);

  @override
  List<Object> get props => [firstName];
}

class LastNameChanged extends EditprofileEvent {
  final String lastName;
  const LastNameChanged(this.lastName);

  @override
  List<Object> get props => [lastName];
}

class EmailChanged extends EditprofileEvent {
  final String email;
  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class CityChanged extends EditprofileEvent {
  final String city;

  const CityChanged(this.city);

  @override
  List<Object> get props => [city];
}
