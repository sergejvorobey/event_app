import 'package:event_app/features/auth/view/auth_screen.dart';
import 'package:event_app/features/launch/view/launch_screen.dart';
import 'package:event_app/features/registration/view/registration_screen.dart';
import 'package:flutter/material.dart';

class Routers {
  static Map<String, WidgetBuilder> get routes {
    return {
      '/launch': (context) => LaunchScreen(),
      '/auth': (context) => AuthScreen(),
      '/registration': (context) => RegistrationScreen(),
      // '/home': (context) => HomeScreen(),
    };
  }
}
