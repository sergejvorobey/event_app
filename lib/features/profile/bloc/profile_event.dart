part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchProfile extends ProfileEvent {
  @override
  List<Object> get props => [];
}

class Content extends ProfileEvent {
  @override
  List<Object> get props => [];
}

class ItemMenuProfilePressed extends ProfileEvent {
  final int index;
  const ItemMenuProfilePressed({required this.index});

  @override
  List<Object> get props => [index];
}