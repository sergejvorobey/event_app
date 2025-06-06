import 'package:event_app/core/navigation/route_observer.dart';
import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:event_app/core/ui/theme/app_text_styles.dart';
import 'package:event_app/core/ui/theme/app_theme.dart';
import 'package:event_app/features/auth/V1/bloc/auth_bloc.dart';
import 'package:event_app/routers/routers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  final talker = Talker();
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>();

  runApp(
    BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        navigatorObservers: [
          TalkerRouteObserver(GetIt.I<Talker>()),
          routeObserver,
        ],
        onGenerateRoute: Routers.generateRoute,
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/launch',
        builder: (context, child) {
          return CupertinoTheme(
            data: const CupertinoThemeData(
              primaryColor: AppColors.primary,
              barBackgroundColor: Colors.white,
              textTheme: CupertinoTextThemeData(
                navTitleTextStyle: AppTextStyles.navigationText,
                navActionTextStyle: AppTextStyles.navigationAction,
              ),
            ),
            child: child!,
          );
        },
      ),
    ),
  );
}