import 'package:event_app/features/city/model/city.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  CityBloc() : super(CityInitial()) {
    on<FetchCities>(_handleFetchCities);
    on<UpdateCities>(_onUpdateCities);
  }

  void _handleFetchCities(FetchCities event, Emitter<CityState> emit) async {
    emit(CityLoading());

    final selectedTitle = event.selectedCityTitle;

    final allCities = [
      'Анапа',
      'Белгород',
      'Брянск',
      'Владимир',
      'Волгоград',
      'Воронеж',
      'Геленджик',
      'Иваново',
      'Калуга',
      'Кострома',
      'Краснодар',
      'Курск',
      'Липецк',
      'Майкоп',
      'Москва',
      'Новороссийск',
      'Орел',
      'Ростов-на-Дону',
      'Рязань',
      'Санкт-Петербург',
      'Смоленск',
      'Сочи',
      'Ставрополь',
      'Тамбов',
      'Тверь',
      'Тула',
      'Ярославль',
    ];

    final cities =
        allCities.map((title) {
          return City(title: title, isSelected: title == selectedTitle);
        }).toList();

    emit(CityContent(cities: cities));
  }

  void _onUpdateCities(UpdateCities event, Emitter<CityState> emit) {
    emit(CityContent(cities: event.updatedCities));
  }
}