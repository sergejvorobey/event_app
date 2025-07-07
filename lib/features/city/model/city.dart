import 'package:equatable/equatable.dart';

class City extends Equatable {
  final String title;
  final bool isSelected;

  const City({required this.title, required this.isSelected});

  City copyWith({bool? isSelected}) {
    return City(
      title: title,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object> get props => [title, isSelected];
}