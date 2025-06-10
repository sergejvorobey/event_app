import 'package:event_app/core/logger/talker_config.dart';
import 'package:event_app/core/network/dio_config.dart';
import 'package:event_app/core/network/network_sevice_v2.dart';
import 'package:event_app/event_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  
   // Инициализация Talker
  final talker = TalkerConfig.createTalker();
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>().debug('Talker started...');

  // Настройка BLoC observer
  Bloc.observer = TalkerConfig.createBlocObserver(talker);

  // Регистрируем NetworkService
  GetIt.I.registerSingleton(NetworkServiceV2(dio: DioConfig.createDio()));

  FlutterError.onError =
      (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

  runApp(const EventApp());
}