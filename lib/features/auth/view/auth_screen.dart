import 'package:event_app/core/ui/common_button.dart';
import 'package:event_app/core/ui/common_text_button.dart';
import 'package:event_app/core/ui/common_text_field.dart';
import 'package:event_app/core/ui/theme/app_text_styles.dart';
import 'package:event_app/core/ui/widgets/common_top_toast_widget.dart';
import 'package:event_app/core/ui/widgets/top_toast.dart';
import 'package:event_app/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {

  // MARK: - Property

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _loginTextFieldFocusNode = FocusNode();
  final FocusNode _passwordTextFieldFocusNode = FocusNode();

  final AuthBloc _authBloc = AuthBloc();

  AuthScreen({super.key});

  // MARK: - Lifecycle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Builder(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: BlocConsumer<AuthBloc, AuthState>(
              bloc: _authBloc,
              listener: (context, state) {
                switch (state) {
                  case AuthSuccess():
                  Navigator.pushReplacementNamed(context, '/home');
                  case AuthError():
                  showTopToast(
                    context: context,
                    title: 'Ошибка',
                    message: state.message,
                    type: ToastType.error
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8,
                        children: [
                          Text(
                            'Добро пожаловать',
                            style: AppTextStyles.headline2,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Введите логин или пароль что бы войти',
                            style: AppTextStyles.textSecondary16,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CommonTextField(
                        label: 'Логин',
                        placeholder: 'Введите логин',
                        hint: 'Начните вводить логин',
                        onValueChanged: _onLoginTextChanged,
                        isStartIndicator: false,
                        hintColor: Colors.grey,
                        isSecure: false,
                        focusNode: _loginTextFieldFocusNode,
                        isShowKeyboard: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CommonTextField(
                        label: 'Пароль',
                        placeholder: 'Введите пароль',
                        hint: 'Начните вводить пароль',
                        onValueChanged: _onPasswordTextChanged,
                        isStartIndicator: false,
                        hintColor: Colors.grey,
                        isSecure: true,
                        focusNode: _passwordTextFieldFocusNode,
                        isShowKeyboard: false,
                      ),
                    ),
                    const SizedBox(height: 48),
                    CommonButton(
                      title: 'Продолжить',
                      action: () {
                        _authBloc.add(
                          LoginButtonPressed(
                            login: _loginController.text,
                            password: _passwordController.text,
                          ),
                        );
                      },
                      isEnabled: true,
                      isShowIndicator: false,
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8,
                        children: [
                          Text(
                            "Нет аккаунта?",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          CommonTextButton(
                            title: "Зарегистрироваться",
                            onPressed: () {
                              // TODO: - Доделать нажатие
                            },
                            isEnabled: true,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  // MARK: - Privates

  void _onLoginTextChanged(String value) {
    _loginController.text = value;
  }

  void _onPasswordTextChanged(String value) {
    _passwordController.text = value;
  }
}
