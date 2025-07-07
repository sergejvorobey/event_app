part of 'city_bloc.dart';

abstract class CityState extends Equatable {
  const CityState();
  
  @override
  List<Object> get props => [];
}

class CityInitial extends CityState {}

class CityLoading extends CityState {
  const CityLoading();
}

class CityContent extends CityState {
  final List<City> cities;

  const CityContent({required this.cities}); 

  @override
  List<Object> get props => [cities];
}
