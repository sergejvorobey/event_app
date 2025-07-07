part of 'city_bloc.dart';

abstract class CityEvent extends Equatable {
  const CityEvent();

  @override
  List<Object> get props => [];
}

class FetchCities extends CityEvent {
  final String? selectedCityTitle;

  const FetchCities({this.selectedCityTitle});

  @override
  List<Object> get props => [selectedCityTitle ?? ""];
}

class UpdateCities extends CityEvent {
  final List<City> updatedCities;

  const UpdateCities(this.updatedCities);
}
