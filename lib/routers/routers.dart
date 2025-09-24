import 'package:auto_route/auto_route.dart';
import 'package:event_app/core/ui/common_empty_state_screen.dart';
import 'package:event_app/core/ui/common_modal_sheet.dart';
import 'package:event_app/features/auth/V1/view/auth_screen.dart';
import 'package:event_app/features/auth/login/view/login_screen.dart';
import 'package:event_app/features/support/city/view/city_screen.dart';
import 'package:event_app/features/user/editProfile/view/edit_profile_screen.dart';
import 'package:event_app/features/menu/employerProfile/view/employer_profile_screen.dart';
import 'package:event_app/features/home/view/home_screen.dart';
import 'package:event_app/features/launch/V1/view/launch_screen.dart';
import 'package:event_app/features/launch/V2/view/launch_screen_v2.dart';
import 'package:event_app/features/main/view/main_screen.dart';
import 'package:event_app/features/user/profile/view/profile_screen.dart';
import 'package:event_app/features/auth/registration/V1/view/registration_screen.dart';
import 'package:event_app/features/menu/resume/view/resume_screen.dart';
import 'package:event_app/features/menu/settings/view/settings_screen.dart';
import 'package:event_app/features/menu/aboutMe/view/about_me_screen.dart';
import 'package:event_app/features/menu/aboutApp/view/about_app_screen.dart';
import 'package:flutter/material.dart';

part 'routers.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: LaunchRouteV2.page,
      path: '/',
      type: RouteType.custom(enablePredictiveBackGesture: false),
    ),
    // AutoRoute(
    //   page: LaunchRoute.page,
    //   path: '/',
    //   type: RouteType.custom(enablePredictiveBackGesture: false),
    // ),
    AutoRoute(page: LoginRoute.page),
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
    AutoRoute(page: AboutAppRoute.page),
    AutoRoute(page: CityRoute.page, fullscreenDialog: true),
    AutoRoute(page: ResumeRoute.page),
    AutoRoute(page: EmployerProfileRoute.page),
    // AutoRoute(page: CommonModalSheetRoute.page),
    // CustomRoute(
    //   page: CommonModalSheetRoute.page,
    //   transitionsBuilder: TransitionsBuilders.slideBottom,
    //   fullscreenDialog: false,
    //   opaque: false,
    //   barrierDismissible: true,
    //   barrierColor: Colors.transparent,
    // ),
  ];
}
