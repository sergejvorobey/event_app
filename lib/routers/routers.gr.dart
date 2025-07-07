// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'routers.dart';

/// generated route for
/// [AuthScreen]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AuthScreen();
    },
  );
}

/// generated route for
/// [CityScreen]
class CityRoute extends PageRouteInfo<CityRouteArgs> {
  CityRoute({
    Key? key,
    String? selectedCityTitle,
    List<PageRouteInfo>? children,
  }) : super(
         CityRoute.name,
         args: CityRouteArgs(key: key, selectedCityTitle: selectedCityTitle),
         initialChildren: children,
       );

  static const String name = 'CityRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CityRouteArgs>(
        orElse: () => const CityRouteArgs(),
      );
      return CityScreen(
        key: args.key,
        selectedCityTitle: args.selectedCityTitle,
      );
    },
  );
}

class CityRouteArgs {
  const CityRouteArgs({this.key, this.selectedCityTitle});

  final Key? key;

  final String? selectedCityTitle;

  @override
  String toString() {
    return 'CityRouteArgs{key: $key, selectedCityTitle: $selectedCityTitle}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CityRouteArgs) return false;
    return key == other.key && selectedCityTitle == other.selectedCityTitle;
  }

  @override
  int get hashCode => key.hashCode ^ selectedCityTitle.hashCode;
}

/// generated route for
/// [CommonEmptyStateScreen]
class CommonEmptyStateRoute extends PageRouteInfo<CommonEmptyStateRouteArgs> {
  CommonEmptyStateRoute({
    Key? key,
    required String title,
    required String subtitle,
    required String actionTitle,
    required VoidCallback action,
    List<PageRouteInfo>? children,
  }) : super(
         CommonEmptyStateRoute.name,
         args: CommonEmptyStateRouteArgs(
           key: key,
           title: title,
           subtitle: subtitle,
           actionTitle: actionTitle,
           action: action,
         ),
         initialChildren: children,
       );

  static const String name = 'CommonEmptyStateRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CommonEmptyStateRouteArgs>();
      return CommonEmptyStateScreen(
        key: args.key,
        title: args.title,
        subtitle: args.subtitle,
        actionTitle: args.actionTitle,
        action: args.action,
      );
    },
  );
}

class CommonEmptyStateRouteArgs {
  const CommonEmptyStateRouteArgs({
    this.key,
    required this.title,
    required this.subtitle,
    required this.actionTitle,
    required this.action,
  });

  final Key? key;

  final String title;

  final String subtitle;

  final String actionTitle;

  final VoidCallback action;

  @override
  String toString() {
    return 'CommonEmptyStateRouteArgs{key: $key, title: $title, subtitle: $subtitle, actionTitle: $actionTitle, action: $action}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CommonEmptyStateRouteArgs) return false;
    return key == other.key &&
        title == other.title &&
        subtitle == other.subtitle &&
        actionTitle == other.actionTitle &&
        action == other.action;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      title.hashCode ^
      subtitle.hashCode ^
      actionTitle.hashCode ^
      action.hashCode;
}

/// generated route for
/// [EditProfileScreen]
class EditProfileRoute extends PageRouteInfo<void> {
  const EditProfileRoute({List<PageRouteInfo>? children})
    : super(EditProfileRoute.name, initialChildren: children);

  static const String name = 'EditProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EditProfileScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [LaunchScreen]
class LaunchRoute extends PageRouteInfo<void> {
  const LaunchRoute({List<PageRouteInfo>? children})
    : super(LaunchRoute.name, initialChildren: children);

  static const String name = 'LaunchRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LaunchScreen();
    },
  );
}

/// generated route for
/// [LaunchScreenV2]
class LaunchRouteV2 extends PageRouteInfo<void> {
  const LaunchRouteV2({List<PageRouteInfo>? children})
    : super(LaunchRouteV2.name, initialChildren: children);

  static const String name = 'LaunchRouteV2';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LaunchScreenV2();
    },
  );
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainScreen();
    },
  );
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileScreen();
    },
  );
}

/// generated route for
/// [RegistrationScreen]
class RegistrationRoute extends PageRouteInfo<void> {
  const RegistrationRoute({List<PageRouteInfo>? children})
    : super(RegistrationRoute.name, initialChildren: children);

  static const String name = 'RegistrationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RegistrationScreen();
    },
  );
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsScreen();
    },
  );
}
