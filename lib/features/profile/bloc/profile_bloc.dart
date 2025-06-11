import 'package:event_app/core/model/result.dart';
import 'package:event_app/core/network/network_sevice_v2.dart';
import 'package:event_app/features/profile/model/profile_menu.dart';
import 'package:event_app/features/profile/repository/profile_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<FetchProfile>(_handleFetchProfile);
    on<ItemMenuProfilePressed>(_handleItemMenuProfilePressed);
  }

  final ProfileRepository _profileRepository = ProfileRepository(
    networkService: NetworkServiceV2(),
  );

  void _handleFetchProfile(
    FetchProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    final result = await _profileRepository.fetchProfile();
    switch (result) {
      case Success(value: final profileResponse):
        emit(
          ProfileContent(
            login: profileResponse.login,
            firstName: profileResponse.firstName,
            lastName: profileResponse.lastName,
            phoneNumber: profileResponse.phoneNumber,
            city: profileResponse.city,
            email: profileResponse.email,
            avatarUrl: profileResponse.avatarUrl,
            isNewUser: profileResponse.isNewUser,
            createdOn: profileResponse.createdOn,
            menu: [
              ProfileMenu(
                icon: CupertinoIcons.person_fill,
                title: "О себе",
                text: "Контактная информация",
              ),
              ProfileMenu(
                icon: CupertinoIcons.person_circle_fill,
                title: "Для соискателя",
                text: "Настройте профиль для поиска работы",
              ),
              ProfileMenu(
                icon: CupertinoIcons.person_crop_circle_fill_badge_plus,
                title: "Для работодателя",
                text: "Настройте профиль для публикации работы",
              ),
              ProfileMenu(
                icon: CupertinoIcons.gear_alt_fill,
                title: "Настройки",
                text: "Общие настройки приложения",
              ),
            ],
          ),
        );
      case Failure(exception: final exception):
        emit(ProfileError(exception.toString()));
    }
  }
}

void _handleItemMenuProfilePressed(
  ItemMenuProfilePressed event,
  Emitter<ProfileState> emit,
) {
  switch (event.index) {
    case 0:
      emit(NavigateToEditProfileScreen());
  }
}
