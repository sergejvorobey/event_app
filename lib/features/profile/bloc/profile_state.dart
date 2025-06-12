part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();

  @override
  List<Object> get props => [];
}

class ProfileContent extends ProfileState {
  final String login;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String city;
  final String email;
  final String avatarUrl;
  final bool isNewUser;
  final String createdOn;
  final List<ProfileMenu> menu;

  const ProfileContent({
    required this.login,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.city,
    required this.email,
    required this.avatarUrl,
    required this.isNewUser,
    required this.createdOn,
    required this.menu,
  });

  ProfileContent copyWith({
    String? login,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? city,
    String? email,
    String? avatarUrl,
    bool? isNewUser,
    String? createdOn,
    List<ProfileMenu>? menu,
  }) {
    return ProfileContent(
      login: login ?? this.login,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isNewUser: isNewUser ?? this.isNewUser,
      createdOn: createdOn ?? this.createdOn,
      menu: menu ?? this.menu,
    );
  }

  @override
  List<Object> get props => [
    login,
    firstName,
    lastName,
    phoneNumber,
    city,
    email,
    avatarUrl,
    isNewUser,
    createdOn,
    menu,
  ];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => 'AuthError: $message';
}

class NavigateToEditProfileScreen extends ProfileState {
  @override
  List<Object?> get props => [];
}

class NavigateToEmptyStateScreen extends ProfileState {
  final String title;
  final String subtitle;
  final String actionTitle;

  const NavigateToEmptyStateScreen({
    required this.title,
    required this.subtitle,
    required this.actionTitle,
  });

  @override
  List<Object?> get props => [];
}
