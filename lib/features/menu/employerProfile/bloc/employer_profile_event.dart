part of 'employer_profile_bloc.dart';

abstract class EmployerProfileEvent extends Equatable {
  const EmployerProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadEmployerProfile extends EmployerProfileEvent {
  const LoadEmployerProfile();
}

class UpdateCompanyName extends EmployerProfileEvent {
  final String companyName;
  const UpdateCompanyName(this.companyName);

  @override
  List<Object?> get props => [companyName];
}

class UpdateCompanyDescription extends EmployerProfileEvent {
  final String description;
  const UpdateCompanyDescription(this.description);

  @override
  List<Object?> get props => [description];
}

class UpdateCompanyWebsite extends EmployerProfileEvent {
  final String website;
  const UpdateCompanyWebsite(this.website);

  @override
  List<Object?> get props => [website];
}

class UpdateCompanyPhone extends EmployerProfileEvent {
  final String phone;
  const UpdateCompanyPhone(this.phone);

  @override
  List<Object?> get props => [phone];
}

class UpdateCompanyEmail extends EmployerProfileEvent {
  final String email;
  const UpdateCompanyEmail(this.email);

  @override
  List<Object?> get props => [email];
}

class UpdateCompanyAddress extends EmployerProfileEvent {
  final String address;
  const UpdateCompanyAddress(this.address);

  @override
  List<Object?> get props => [address];
}

class SaveEmployerProfile extends EmployerProfileEvent {
  const SaveEmployerProfile();
}

