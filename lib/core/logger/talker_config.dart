import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerConfig {
  static Talker createTalker() {
    final talker = Talker(
      logger: TalkerLogger(settings: TalkerLoggerSettings()),
      settings: TalkerSettings(
        colors: {
          TalkerLogType.httpRequest.key: AnsiPen()..blue(),
          TalkerLogType.httpError.key: AnsiPen()..cyan(),
          TalkerLogType.httpResponse.key: AnsiPen()..green(),
          TalkerLogType.blocEvent.key: AnsiPen()..magenta(),
          TalkerLogType.blocTransition.key: AnsiPen()..magenta(),
          TalkerLogType.blocClose.key: AnsiPen()..magenta(),
        },
      ),
    );
    return talker;
  }

  static TalkerBlocObserver createBlocObserver(Talker talker) {
    return TalkerBlocObserver(
      talker: talker,
      settings: const TalkerBlocLoggerSettings(
        printStateFullData: false,
        printEventFullData: false,
      ),
    );
  }

  static TalkerDioLogger createDioLogger(Talker talker) {
    return TalkerDioLogger(
      talker: talker,
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
