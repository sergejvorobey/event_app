import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:event_app/core/ui/theme/app_text_styles.dart';
import 'package:event_app/core/ui/theme/app_theme.dart';
import 'package:event_app/features/auth/bloc/auth_bloc.dart';
import 'package:event_app/features/auth/view/auth_screen.dart';
import 'package:event_app/features/home/view/home_screen.dart';
import 'package:event_app/features/registration/view/registration_screen.dart';
import 'package:event_app/routers/routers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/auth':
              return CupertinoPageRoute(
                builder: (context) => const AuthScreen(),
                settings: settings,
              );
            case '/registration':
              return CupertinoPageRoute(
                builder: (context) => const RegistrationScreen(),
                settings: settings,
              );
              case '/home':
              return CupertinoPageRoute(
                builder: (context) => const HomeScreen(),
                settings: settings,
                fullscreenDialog: true
              );
          }
          return null;
        },
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/launch',
        routes: Routers.routes,
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