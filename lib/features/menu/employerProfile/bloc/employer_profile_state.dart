part of 'employer_profile_bloc.dart';

abstract class EmployerProfileState extends Equatable {
  const EmployerProfileState();

  @override
  List<Object?> get props => [];
}

class EmployerProfileInitial extends EmployerProfileState {}

class EmployerProfileLoading extends EmployerProfileState {}

class EmployerProfileLoaded extends EmployerProfileState {
  final String companyName;
  final String companyDescription;
  final String companyWebsite;
  final String companyPhone;
  final String companyEmail;
  final String companyAddress;
  final bool isVerified;

  const EmployerProfileLoaded({
    required this.companyName,
    required this.companyDescription,
    required this.companyWebsite,
    required this.companyPhone,
    required this.companyEmail,
    required this.companyAddress,
    required this.isVerified,
  });

  EmployerProfileLoaded copyWith({
    String? companyName,
    String? companyDescription,
    String? companyWebsite,
    String? companyPhone,
    String? companyEmail,
    String? companyAddress,
    bool? isVerified,
  }) {
    return EmployerProfileLoaded(
      companyName: companyName ?? this.companyName,
      companyDescription: companyDescription ?? this.companyDescription,
      companyWebsite: companyWebsite ?? this.companyWebsite,
      companyPhone: companyPhone ?? this.companyPhone,
      companyEmail: companyEmail ?? this.companyEmail,
      companyAddress: companyAddress ?? this.companyAddress,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  @override
  List<Object?> get props => [
    companyName,
    companyDescription,
    companyWebsite,
    companyPhone,
    companyEmail,
    companyAddress,
    isVerified,
  ];
}

class EmployerProfileSaving extends EmployerProfileState {}

class EmployerProfileSaved extends EmployerProfileState {
  final String message;
  const EmployerProfileSaved(this.message);

  @override
  List<Object?> get props => [message];
}

class EmployerProfileError extends EmployerProfileState {
  final String message;
  const EmployerProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

