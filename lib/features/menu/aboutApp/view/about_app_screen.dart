import 'package:auto_route/auto_route.dart';
import 'package:event_app/core/ui/Navigation/common_navigation_bar.dart';
import 'package:event_app/core/ui/common_button.dart';
import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:event_app/core/ui/theme/app_text_styles.dart';
import 'package:event_app/core/ui/widgets/common_top_toast_widget.dart';
import 'package:event_app/core/ui/widgets/top_toast.dart';
import 'package:event_app/features/menu/aboutApp/bloc/about_app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  final AboutAppBloc _aboutAppBloc = AboutAppBloc();

  @override
  void initState() {
    super.initState();
    _aboutAppBloc.add(const LoadAppInfo());
  }

  @override
  void dispose() {
    _aboutAppBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonNavigationBar(
        previousPageTitle: "Назад",
        title: "О приложении",
      ),
      body: BlocProvider(
        create: (context) => _aboutAppBloc,
        child: BlocConsumer<AboutAppBloc, AboutAppState>(
          listener: (context, state) {
            if (state is AboutAppFeedbackSent) {
              showToast(
                title: 'Успешно',
                message: state.message,
                type: ToastType.success,
              );
            } else if (state is AboutAppError) {
              showToast(
                title: 'Ошибка',
                message: state.message,
                type: ToastType.error,
              );
            }
          },
          builder: (context, state) {
            if (state is AboutAppLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AboutAppLoaded) {
              return _buildContent(state);
            } else if (state is AboutAppError) {
              return _buildErrorState(state.message);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildContent(AboutAppLoaded state) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 0,
          children: [
            // Иконка приложения
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: AppColors.greyLight)],
              ),
            ),
            const SizedBox(height: 16),

            // Название приложения
            Text(
              state.appName,
              style: AppTextStyles.headline1.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Описание приложения
            Text(
              state.appDescription,
              style: AppTextStyles.bodyText1.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Билд и версия
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Версия:', style: AppTextStyles.bodyText1),
                const SizedBox(width: 4),
                Text(
                  "${state.version} (${state.buildNumber})",
                  style: AppTextStyles.bodyText1,
                ),
              ],
            ),
            const Spacer(),

            // Кнопка обратной связи
            CommonButton(
              title: "Написать разработчику",
              isEnabled: true,
              action:
                  () => {
                    // TODO: - Добавить кнопку
                  },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: AppColors.textSecondary),
          const SizedBox(height: 16),
          Text(
            'Произошла ошибка',
            style: AppTextStyles.headline2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: AppTextStyles.bodyText1.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              _aboutAppBloc.add(const LoadAppInfo());
            },
            child: const Text('Повторить'),
          ),
        ],
      ),
    );
  }
}
