import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

class DioConfig {
  // static final _baseUrl = 'http://194.87.236.187:8080/';
  static final _baseUrl = 'http://localhost:3000/api/';

  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: DioConfig._baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    // Добавляем логгер первым
    dio.interceptors.add(_createLoggerInterceptor());

    // Затем добавляем остальные интерцепторы
    return dio;
  }

  static TalkerDioLogger _createLoggerInterceptor() {
    return TalkerDioLogger(
      talker: GetIt.I<Talker>(),
      settings: TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: true,
        requestPen: AnsiPen()..blue(),
        responsePen: AnsiPen()..green(),
        errorPen: AnsiPen()..red(),
      ),
    );
  }
}
