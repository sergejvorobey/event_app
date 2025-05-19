import 'package:event_app/core/ui/theme/app_theme.dart';
import 'package:event_app/features/auth/bloc/auth_bloc.dart';
import 'package:event_app/features/auth/view/auth_screen.dart';
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
          }
          return null;
        },
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/launch',
        routes: Routers.routes,
      ),
    ),
  );
}
