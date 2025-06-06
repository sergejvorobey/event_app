import 'package:flutter_bloc/flutter_bloc.dart';

class TabVisibilityCubit extends Cubit<bool> {
  TabVisibilityCubit() : super(true);

  void show() => emit(true);
  void hide() => emit(false);
}