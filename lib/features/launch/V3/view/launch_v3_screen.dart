import 'package:auto_route/auto_route.dart';
import 'package:event_app/core/ui/common_button.dart';
import 'package:event_app/core/ui/common_text_button.dart';
import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:event_app/core/ui/theme/app_text_styles.dart';
import 'package:event_app/features/launch/V3/bloc/launch_v3_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class LaunchScreenV3 extends StatefulWidget {
  const LaunchScreenV3({super.key});

  @override
  LaunchScreenV3State createState() => LaunchScreenV3State();
}

final class LaunchScreenV3State extends State<LaunchScreenV3> {
  final LaunchV3Bloc _launchBloc = LaunchV3Bloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _content(),
    );
  }

  Widget _content() {
    return BlocConsumer<LaunchV3Bloc, LaunchV3State>(
      bloc: _launchBloc,
      listener: (context, state) {
        // switch (state) {
        //   case NavigateToHomeScreen():
        //     AutoRouter.of(context).push(HomeRoute()).then((_) {
        //       _launchBloc.add(LaunchV2Content());
        //     });
        //     break;

        //   case NavigateToLoginScreen():
        //     AutoRouter.of(context).push(LoginRoute()).then((_) {
        //       _launchBloc.add(LaunchV2Content());
        //     });
        //     break;

        //   case NavigateToRegistrationScreen():
        //     AutoRouter.of(context).push(RegistrationRoute()).then((_) {
        //       _launchBloc.add(LaunchV2Content());
        //     });
        //     break;
        // }
      },
      builder: (BuildContext context, LaunchV3State state) {
        if (state is LaunchV3Initial) {
          return _buildLaunch(state);
        }
        // if (state is LaunchV2Loading) {
        //   return _buildLoadingIndicator();
        // }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLaunch(LaunchV3Initial state) {
    return Stack(
      children: [
        // 1. Картинка на заднем плане
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/icons/Onboarding_3.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // 2. Текст поверх картинки
        Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 42),
          child: Column(
            spacing: 16,
            children: [
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Лучшие места",
                    style: AppTextStyles.headline34White,
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    spacing: 6,
                    children: [
                      Text(
                        "забирают",
                        style: AppTextStyles.headline34White,
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "быстро",
                        style: TextStyle(
                          fontSize: 34,
                          letterSpacing: 0.2,
                          fontFamily: 'SFRounded',
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                "Не упустите горячие заказы. Создайте профиль и начните зарабатывать или нанимать сегодня",
                style: AppTextStyles.bodyText1White,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 8),
              CommonButton(
                title: 'Войти',
                action: () {
                  // _onboardingBloc.add(NextButtonPressed());
                },
                isEnabled: true,
                isShowIndicator: false,
              ),
              CommonTextButton(title: "Создать аккаунт", onPressed: () => {}),
              const SizedBox(height: 16),
              _buildAgreementText(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAgreementText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: AppTextStyles.textSecondary12White,
          children: [
            const TextSpan(
              text: 'Продолжая, вы соглашаетесь с ',
            ),
            TextSpan(
              text: 'правилами сервиса',
              style: const TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.white,
              ),
              recognizer: TapGestureRecognizer()..onTap = () => _launchTerms(),
            ),
            const TextSpan(
              text: ' и ',
            ),
            TextSpan(
              text: 'политикой конфиденциальности',
              style: const TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.white,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => _launchPrivacyPolicy(),
            ),
          ],
        ),
      ),
    );
  }

  // Метод для открытия правил сервиса
  Future<void> _launchTerms() async {
    final url = Uri.parse('https://ваш-сайт.com/terms'); // Замените на ваш URL
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: true,
        ),
      );
    } else {
      _showErrorSnackbar('Не удалось открыть ссылку');
    }
  }

  // Метод для открытия политики конфиденциальности
  Future<void> _launchPrivacyPolicy() async {
    final url =
        Uri.parse('https://ваш-сайт.com/privacy'); // Замените на ваш URL
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: true,
        ),
      );
    } else {
      _showErrorSnackbar('Не удалось открыть ссылку');
    }
  }

  // Альтернатива: открыть в WebView внутри приложения
  Future<void> _launchInAppWebView(String urlString, String title) async {
    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
        webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'},
          enableJavaScript: true,
          enableDomStorage: true,
        ),
      );
    } else {
      _showErrorSnackbar('Не удалось открыть ссылку');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
