import 'package:event_app/core/ui/common_button.dart';
import 'package:event_app/core/ui/common_text_button.dart';
import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:event_app/core/ui/theme/app_text_styles.dart';
import 'package:event_app/features/launch/V1/bloc/launch_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  LaunchScreenState createState() => LaunchScreenState();
}

final class LaunchScreenState extends State<LaunchScreen> {
  // MARK: - Property

  final LaunchBloc _launchBloc = LaunchBloc();
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
    _launchBloc.add(LaunchContent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _content());
  }

  // MARK: - Privates

  Widget _content() {
    return SafeArea(
      child: BlocConsumer<LaunchBloc, LaunchState>(
        bloc: _launchBloc,
        listener: (context, state) {
          switch (state) {
            case NavigateToHomeScreen():
              Navigator.pushNamed(context, '/home');
              break;

            case NavigateToLoginScreen():
              Navigator.pushNamed(context, '/auth').then((_) {
                _launchBloc.add(LaunchContent());
              });
              break;

            case NavigateToRegistrationScreen():
              Navigator.pushNamed(context, '/registration').then((_) {
                _launchBloc.add(LaunchContent());
              });
              break;
          }
        },
        builder: (BuildContext context, LaunchState state) {
          if (state is LaunchInitial) {
            return buildOnboarding(state);
          }
          if (state is LaunchLoading) {
            return _buildLoadingIndicator();
          }
          return const Spacer();
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

  Column buildOnboarding(LaunchInitial state) {
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
