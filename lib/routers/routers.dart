import 'package:auto_route/auto_route.dart';
import 'package:event_app/features/auth/V1/view/auth_screen.dart';
import 'package:event_app/features/home/view/home_screen.dart';
import 'package:event_app/features/launch/V1/view/launch_screen.dart';
import 'package:event_app/features/launch/V2/view/launch_screen_v2.dart';
import 'package:event_app/features/profile/view/profile_screen.dart';
import 'package:event_app/features/registration/V1/view/registration_screen.dart';

part 'routers.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LaunchRouteV2.page), //, path: '/'),
    AutoRoute(page: LaunchRoute.page, path: '/'),
    AutoRoute(page: AuthRoute.page),
    AutoRoute(page: RegistrationRoute.page),
    AutoRoute(page: HomeRoute.page),
  ];
}
