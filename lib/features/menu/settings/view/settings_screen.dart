import 'package:auto_route/auto_route.dart';
import 'package:event_app/core/ui/Navigation/common_navigation_bar.dart';
import 'package:event_app/core/ui/common_text_button.dart';
import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:event_app/core/ui/theme/app_text_styles.dart';
import 'package:event_app/core/ui/widgets/common_top_toast_widget.dart';
import 'package:event_app/core/ui/widgets/top_toast.dart';
import 'package:event_app/features/menu/settings/bloc/settings_bloc.dart';
import 'package:event_app/routers/routers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with RouteAware {
  final SettingsBloc _settingsBloc = SettingsBloc();

  @override
  void initState() {
    super.initState();
    _settingsBloc.add(LoadNotificationStatus());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonNavigationBar(
        previousPageTitle: "Назад",
        title: "Настройки",
      ),
      body: _content(),
    );
  }

  Widget _content() {
    return SafeArea(
      child: BlocConsumer<SettingsBloc, SettingsState>(
        bloc: _settingsBloc,
        listener: (context, state) {
          switch (state) {
            case SettingsLoaded():
              _settingsBloc.add(LoadNotificationStatus());
              break;

            case SettingsSuccess():
              AutoRouter.of(context).push(LaunchRoute());
              break;

            case SettingsError(:final message):
              showToast(
                title: 'Ошибка',
                message: message,
                type: ToastType.error,
              );
              break;
          }
        },
        builder: (BuildContext context, SettingsState state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.greyLight.withAlpha(150),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 8,
                          bottom: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Уведомления",
                              style: AppTextStyles.bodyText1,
                            ),
                            CupertinoSwitch(
                              value: state.notificationsEnabled,
                              onChanged: (value) {
                                _settingsBloc.add(ToggleNotifications(value));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.greyLight.withAlpha(150),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16,
                          bottom: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonTextButton(
                              title: "Выйти",
                              onPressed: () {
                                _settingsBloc.add(LogOutButtonPressed());
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Ссылка на экран "О приложении"
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.greyLight.withAlpha(150),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16,
                          bottom: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonTextButton(
                              title: "О приложении",
                              onPressed: () {
                                AutoRouter.of(
                                  context,
                                ).push(const AboutAppRoute());
                              },
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: AppColors.textSecondary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
