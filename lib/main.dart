import 'package:event_app/core/ui/theme/app_theme.dart';
import 'package:event_app/features/auth/bloc/auth_bloc.dart';
import 'package:event_app/features/auth/view/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/auth',
        routes: {
          '/auth': (context) => AuthScreen(),
          // '/register': (context) => RegisterScreen(), // Регистрация
          // '/home': (context) => HomeScreen(), // Главный экран
        },
      ),
    ),
  );
}
