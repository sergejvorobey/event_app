import 'package:event_app/core/logger/talker_config.dart';
import 'package:event_app/core/network/dio_config.dart';
import 'package:event_app/core/network/network_sevice_v2.dart';
import 'package:event_app/core/notification/notification_service.dart';
import 'package:event_app/event_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:toastification/toastification.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация Talker
  final talker = TalkerConfig.createTalker();
  getIt.registerSingleton(talker);
  getIt<Talker>().debug('Talker started...');

  // Настройка BLoC observer
  Bloc.observer = TalkerConfig.createBlocObserver(talker);

  // Регистрируем NetworkService
  getIt.registerSingleton(NetworkServiceV2(dio: DioConfig.createDio()));

  // Регистрируем сервис
  getIt.registerSingleton<NotificationService>(NotificationService());

  // Вызываем запрос на разрешение
  final notificationsEnabled =
      await getIt<NotificationService>().requestNotificationPermission();

  getIt<Talker>().debug('Notifications enabled: $notificationsEnabled');

  FlutterError.onError =
      (details) => getIt<Talker>().handle(details.exception, details.stack);

  runApp(ToastificationWrapper(child: const EventApp()));
}