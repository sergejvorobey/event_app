// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'routers.dart';

/// generated route for
/// [AboutAppScreen]
class AboutAppRoute extends PageRouteInfo<void> {
  const AboutAppRoute({List<PageRouteInfo>? children})
      : super(AboutAppRoute.name, initialChildren: children);

  static const String name = 'AboutAppRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AboutAppScreen();
    },
  );
}

/// generated route for
/// [AboutMeScreen]
class AboutMeRoute extends PageRouteInfo<void> {
  const AboutMeRoute({List<PageRouteInfo>? children})
      : super(AboutMeRoute.name, initialChildren: children);

  static const String name = 'AboutMeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AboutMeScreen();
    },
  );
}

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
    VoidCallback? closeAction,
    List<PageRouteInfo>? children,
  }) : super(
          CommonEmptyStateRoute.name,
          args: CommonEmptyStateRouteArgs(
            key: key,
            title: title,
            subtitle: subtitle,
            actionTitle: actionTitle,
            action: action,
            closeAction: closeAction,
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
        closeAction: args.closeAction,
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
    this.closeAction,
  });

  final Key? key;

  final String title;

  final String subtitle;

  final String actionTitle;

  final VoidCallback action;

  final VoidCallback? closeAction;

  @override
  String toString() {
    return 'CommonEmptyStateRouteArgs{key: $key, title: $title, subtitle: $subtitle, actionTitle: $actionTitle, action: $action, closeAction: $closeAction}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CommonEmptyStateRouteArgs) return false;
    return key == other.key &&
        title == other.title &&
        subtitle == other.subtitle &&
        actionTitle == other.actionTitle &&
        action == other.action &&
        closeAction == other.closeAction;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      title.hashCode ^
      subtitle.hashCode ^
      actionTitle.hashCode ^
      action.hashCode ^
      closeAction.hashCode;
}

/// generated route for
/// [CommonModalSheetScreen]
class CommonModalSheetRoute extends PageRouteInfo<CommonModalSheetRouteArgs> {
  CommonModalSheetRoute({
    Key? key,
    required Widget child,
    double heightFactor = 0.86,
    List<PageRouteInfo>? children,
  }) : super(
          CommonModalSheetRoute.name,
          args: CommonModalSheetRouteArgs(
            key: key,
            child: child,
            heightFactor: heightFactor,
          ),
          initialChildren: children,
        );

  static const String name = 'CommonModalSheetRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CommonModalSheetRouteArgs>();
      return CommonModalSheetScreen(
        key: args.key,
        child: args.child,
        heightFactor: args.heightFactor,
      );
    },
  );
}

class CommonModalSheetRouteArgs {
  const CommonModalSheetRouteArgs({
    this.key,
    required this.child,
    this.heightFactor = 0.86,
  });

  final Key? key;

  final Widget child;

  final double heightFactor;

  @override
  String toString() {
    return 'CommonModalSheetRouteArgs{key: $key, child: $child, heightFactor: $heightFactor}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CommonModalSheetRouteArgs) return false;
    return key == other.key &&
        child == other.child &&
        heightFactor == other.heightFactor;
  }

  @override
  int get hashCode => key.hashCode ^ child.hashCode ^ heightFactor.hashCode;
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
/// [EmployerProfileScreen]
class EmployerProfileRoute extends PageRouteInfo<void> {
  const EmployerProfileRoute({List<PageRouteInfo>? children})
      : super(EmployerProfileRoute.name, initialChildren: children);

  static const String name = 'EmployerProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EmployerProfileScreen();
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
/// [LaunchScreenV3]
class LaunchRouteV3 extends PageRouteInfo<void> {
  const LaunchRouteV3({List<PageRouteInfo>? children})
      : super(LaunchRouteV3.name, initialChildren: children);

  static const String name = 'LaunchRouteV3';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LaunchScreenV3();
    },
  );
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginScreen();
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
/// [OnboardingScreen]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
      : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OnboardingScreen();
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
/// [ResumeScreen]
class ResumeRoute extends PageRouteInfo<void> {
  const ResumeRoute({List<PageRouteInfo>? children})
      : super(ResumeRoute.name, initialChildren: children);

  static const String name = 'ResumeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ResumeScreen();
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
