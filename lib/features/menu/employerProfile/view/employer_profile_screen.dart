import 'package:auto_route/auto_route.dart';
import 'package:event_app/core/ui/Navigation/common_navigation_bar.dart';
import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:event_app/core/ui/theme/app_text_styles.dart';
import 'package:event_app/core/ui/common_text_field.dart';
import 'package:event_app/core/ui/widgets/common_top_toast_widget.dart';
import 'package:event_app/core/ui/widgets/top_toast.dart';
import 'package:event_app/features/menu/employerProfile/bloc/employer_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EmployerProfileScreen extends StatefulWidget {
  const EmployerProfileScreen({super.key});

  @override
  State<EmployerProfileScreen> createState() => _EmployerProfileScreenState();
}

class _EmployerProfileScreenState extends State<EmployerProfileScreen> {
  final EmployerProfileBloc _employerProfileBloc = EmployerProfileBloc();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _employerProfileBloc.add(const LoadEmployerProfile());
  }

  @override
  void dispose() {
    _employerProfileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonNavigationBar(
        previousPageTitle: "Назад",
        title: "Профиль работодателя",
      ),
      body: BlocProvider(
        create: (context) => _employerProfileBloc,
        child: BlocConsumer<EmployerProfileBloc, EmployerProfileState>(
          listener: (context, state) {
            if (state is EmployerProfileSaved) {
              showToast(
                title: 'Успешно',
                message: state.message,
                type: ToastType.success,
              );
            } else if (state is EmployerProfileError) {
              showToast(
                title: 'Ошибка',
                message: state.message,
                type: ToastType.error,
              );
            }
          },
          builder: (context, state) {
            if (state is EmployerProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EmployerProfileLoaded) {
              return _buildContent(state);
            } else if (state is EmployerProfileSaving) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Сохранение...'),
                  ],
                ),
              );
            } else if (state is EmployerProfileError) {
              return _buildErrorState(state.message);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildContent(EmployerProfileLoaded state) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Заголовок
              Text(
                'Информация о компании',
                style: AppTextStyles.headline2.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Статус верификации
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color:
                      state.isVerified
                          ? AppColors.primary.withAlpha(50)
                          : AppColors.textSecondary.withAlpha(50),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        state.isVerified
                            ? AppColors.primary
                            : AppColors.textSecondary,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      state.isVerified ? Icons.verified : Icons.pending_actions,
                      color:
                          state.isVerified
                              ? AppColors.primary
                              : AppColors.textSecondary,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        state.isVerified
                            ? 'Компания верифицирована'
                            : 'Ожидает верификации',
                        style: AppTextStyles.bodyText1.copyWith(
                          fontWeight: FontWeight.w600,
                          color:
                              state.isVerified
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Поля формы
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Название компании
                      CommonTextField(
                        label: 'Название компании',
                        placeholder: 'Введите название компании',
                        value: state.companyName,
                        onValueChanged: (value) {
                          _employerProfileBloc.add(UpdateCompanyName(value));
                        },
                      ),
                      const SizedBox(height: 16),

                      // Описание компании
                      CommonTextField(
                        label: 'Описание компании',
                        placeholder: 'Введите описание компании',
                        value: state.companyDescription,
                        onValueChanged: (value) {
                          _employerProfileBloc.add(
                            UpdateCompanyDescription(value),
                          );
                        },
                      ),
                      const SizedBox(height: 16),

                      // Веб-сайт
                      CommonTextField(
                        label: 'Веб-сайт',
                        placeholder: 'https://company.com',
                        value: state.companyWebsite,
                        onValueChanged: (value) {
                          _employerProfileBloc.add(UpdateCompanyWebsite(value));
                        },
                      ),
                      const SizedBox(height: 16),

                      // Телефон
                      CommonTextField(
                        label: 'Телефон',
                        placeholder: '+7 (999) 123-45-67',
                        value: state.companyPhone,
                        onValueChanged: (value) {
                          _employerProfileBloc.add(UpdateCompanyPhone(value));
                        },
                      ),
                      const SizedBox(height: 16),

                      // Email
                      CommonTextField(
                        label: 'Email',
                        placeholder: 'info@company.com',
                        value: state.companyEmail,
                        onValueChanged: (value) {
                          _employerProfileBloc.add(UpdateCompanyEmail(value));
                        },
                      ),
                      const SizedBox(height: 16),

                      // Адрес
                      CommonTextField(
                        label: 'Адрес',
                        placeholder: 'Введите адрес компании',
                        value: state.companyAddress,
                        onValueChanged: (value) {
                          _employerProfileBloc.add(UpdateCompanyAddress(value));
                        },
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),

              // Кнопка сохранения
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _employerProfileBloc.add(const SaveEmployerProfile());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Сохранить',
                    style: AppTextStyles.bodyText1.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
              _employerProfileBloc.add(const LoadEmployerProfile());
            },
            child: const Text('Повторить'),
          ),
        ],
      ),
    );
  }
}
