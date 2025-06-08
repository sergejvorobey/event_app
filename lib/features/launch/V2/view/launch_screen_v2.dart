import 'package:auto_route/auto_route.dart';
import 'package:event_app/core/ui/common_button.dart';
import 'package:event_app/core/ui/common_text_button.dart';
import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:event_app/core/ui/theme/app_text_styles.dart';
import 'package:event_app/features/launch/V2/bloc/launch_v2_bloc.dart';
import 'package:event_app/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LaunchScreenV2 extends StatefulWidget {
  const LaunchScreenV2({super.key});

  @override
  LaunchScreenV2State createState() => LaunchScreenV2State();
}

final class LaunchScreenV2State extends State<LaunchScreenV2> {
  final LaunchV2Bloc _launchBloc = LaunchV2Bloc();
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _launchBloc.close();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _launchBloc.add(LaunchV2Content());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _content());
  }

  Widget _content() {
    return SafeArea(
      child: BlocConsumer<LaunchV2Bloc, LaunchV2State>(
        bloc: _launchBloc,
        listener: (context, state) {
          switch (state) {
            case NavigateToHomeScreen():
              AutoRouter.of(context).push(HomeRoute()).then((_) {
                _launchBloc.add(LaunchV2Content());
              });
              break;

            case NavigateToLoginScreen():
              AutoRouter.of(context).push(AuthRoute()).then((_) {
                _launchBloc.add(LaunchV2Content());
              });
              break;

            case NavigateToRegistrationScreen():
              AutoRouter.of(context).push(RegistrationRoute()).then((_) {
                _launchBloc.add(LaunchV2Content());
              });
              break;
          }
        },
        builder: (BuildContext context, LaunchV2State state) {
          if (state is LaunchV2Initial) {
            return buildOnboarding(state);
          }
          if (state is LaunchV2Loading) {
            return _buildLoadingIndicator();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        strokeWidth: 3.0,
        strokeAlign: -3.0,
      ),
    );
  }

  Column buildOnboarding(LaunchV2Initial state) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 32,
                    bottom: 32,
                    left: 16,
                    right: 16,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/icons/welcome.png',
                      width: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                for (int i = 0; i < state.pages.length; i++) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(40),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(
                            state.pages[i].icon,
                            width: 16,
                            height: 16,
                            fit: BoxFit.contain,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.pages[i].title,
                              style: AppTextStyles.headline16,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              state.pages[i].onboarding,
                              style: AppTextStyles.textSecondary14,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (i != state.pages.length - 1) const SizedBox(height: 16),
                ],
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            spacing: 16,
            children: [
              CommonButton(
                title: 'Войти',
                action: () {
                  _launchBloc.add(LoginButtonPressed());
                },
                isEnabled: true,
                isShowIndicator: false,
              ),
              CommonTextButton(
                title: "Зарегистрироваться",
                onPressed: () {
                  _launchBloc.add(RegistrationButtonPressed());
                },
                isEnabled: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}