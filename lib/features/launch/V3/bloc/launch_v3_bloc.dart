import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'launch_v3_event.dart';
part 'launch_v3_state.dart';

class LaunchV3Bloc extends Bloc<LaunchV3Event, LaunchV3State> {
  LaunchV3Bloc() : super(LaunchV3Initial()) {
    on<LaunchV3Event>((event, emit) {
      // TODO: implement event handler
    });
  }
}
