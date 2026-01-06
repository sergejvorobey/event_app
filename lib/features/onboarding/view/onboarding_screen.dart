import 'package:auto_route/auto_route.dart';
import 'package:event_app/core/ui/common_button.dart';
import 'package:event_app/core/ui/common_page_control.dart';
import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:event_app/core/ui/theme/app_text_styles.dart';
import 'package:event_app/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

final class OnboardingScreenState extends State<OnboardingScreen> {
  final OnboardingBloc _onboardingBloc = OnboardingBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _content());
  }

  Widget _content() {
    return SafeArea(
      child: BlocConsumer<OnboardingBloc, OnboardingState>(
        bloc: _onboardingBloc,
        listener: (context, state) {},
        builder: (BuildContext context, OnboardingState state) {
          if (state is OnboardingInitial) {
            return buildOnboarding(state);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget buildOnboarding(OnboardingInitial state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        spacing: 0,
        children: [
          const SizedBox(height: 32),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: Container(
              key: ValueKey(state.imagePath),
              child: Center(
                child: Image.asset(
                  state.imagePath,
                  width: 375,
                  height: 375,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Spacer(),
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32)),
            child: Container(
              height: 350,
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      spacing: 0,
                      children: [
                        Text(
                          state.title,
                          style: AppTextStyles.headline1,
                          textAlign: TextAlign.center,
                        ),
                        Text(state.subtitle,
                            style: TextStyle(
                              fontSize: 28,
                              letterSpacing: 0.2,
                              fontFamily: 'SFRounded',
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                            textAlign: TextAlign.center),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          state.description,
                          style: AppTextStyles.textSecondary16,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    CommonPageControl(
                      currentPage: state.currentPage,
                      pageCount: _onboardingBloc.pages.length,
                      activeColor: AppColors.primary,
                      inactiveColor: Colors.grey.shade300,
                    ),

                    const SizedBox(height: 32),

                    // Кнопка
                    CommonButton(
                      title: 'Далее',
                      color: AppColors.secondaryCommonButton,
                      action: () {
                        _onboardingBloc.add(NextButtonPressed());
                      },
                      isEnabled: true,
                      isShowIndicator: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
