import 'package:event_app/features/auth/V1/view/auth_screen.dart';
import 'package:event_app/features/editProfile/view/edit_profile_screen.dart';
import 'package:event_app/features/home/view/home_screen.dart';
import 'package:event_app/features/launch/V1/view/launch_screen.dart';
import 'package:event_app/features/registration/V1/view/registration_screen.dart';
import 'package:flutter/cupertino.dart';


class Routers {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/launch':
        return CupertinoPageRoute(
          builder: (_) => const LaunchScreen(),
          settings: settings,
        );
      case '/auth':
        return CupertinoPageRoute(
          builder: (_) => const AuthScreen(),
          settings: settings,
        );
      case '/registration':
        return CupertinoPageRoute(
          builder: (_) => const RegistrationScreen(),
          settings: settings,
        );
      case '/home':
        return CupertinoPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
          fullscreenDialog: true,
        );
        case '/editProfile':
        return CupertinoPageRoute(
          builder: (_) => const EditProfileScreen(),
          settings: settings
        );
    }
    return null;
  }
}
