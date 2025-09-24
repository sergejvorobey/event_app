import 'package:event_app/core/navigation/route_observer.dart';
import 'package:event_app/core/ui/theme/app_theme.dart';
import 'package:event_app/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _appRouter = AppRouter();

  // TODO: - Добавить Android/iOS flow (Тема светлая/темная)

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.config(
        navigatorObservers:
            () => [TalkerRouteObserver(GetIt.I<Talker>()), routeObserver],
      ),
    );
  }
}
