import 'package:auto_route/auto_route.dart';
import 'package:event_app/core/ui/common_empty_state_screen.dart';
import 'package:event_app/features/auth/V1/view/auth_screen.dart';
import 'package:event_app/features/city/view/city_screen.dart';
import 'package:event_app/features/editProfile/view/edit_profile_screen.dart';
import 'package:event_app/features/home/view/home_screen.dart';
import 'package:event_app/features/launch/V1/view/launch_screen.dart';
import 'package:event_app/features/launch/V2/view/launch_screen_v2.dart';
import 'package:event_app/features/main/view/main_screen.dart';
import 'package:event_app/features/profile/view/profile_screen.dart';
import 'package:event_app/features/registration/V1/view/registration_screen.dart';
import 'package:event_app/features/settings/view/settings_screen.dart';
import 'package:flutter/material.dart';

part 'routers.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LaunchRouteV2.page),
    AutoRoute(
      page: LaunchRoute.page,
      path: '/',
      type: RouteType.custom(enablePredictiveBackGesture: false),
    ),
    AutoRoute(page: AuthRoute.page),
    AutoRoute(page: RegistrationRoute.page),
    AutoRoute(
      page: HomeRoute.page,
      type: RouteType.custom(enablePredictiveBackGesture: false),
      children: [
        AutoRoute(page: MainRoute.page),
        AutoRoute(page: ProfileRoute.page),
      ],
    ),
    AutoRoute(page: EditProfileRoute.page),
    AutoRoute(page: CommonEmptyStateRoute.page, fullscreenDialog: true),
    AutoRoute(page: SettingsRoute.page),
    AutoRoute(page: CityRoute.page, fullscreenDialog: true),
  ];
}
