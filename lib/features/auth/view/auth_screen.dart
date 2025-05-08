import 'package:event_app/core/ui/common_button.dart';
import 'package:event_app/core/ui/common_text_field.dart';
import 'package:event_app/core/ui/theme/app_text_styles.dart';
import 'package:event_app/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _loginTextFieldFocusNode = FocusNode();
  final FocusNode _passwordTextFieldFocusNode = FocusNode();

  AuthScreen({super.key});

  void _onLoginTextChanged(String value) {
    _loginController.text = value;
  }

  void _onPasswordTextChanged(String value) {
    _passwordController.text = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              // Переход на главный экран после успешного входа
              Navigator.pushReplacementNamed(context, '/home');
            }
            if (state is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
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
                const SizedBox(height: 32),
                CommonButton(
                  title: 'Продолжить',
                  action: () {
                    // Ваше действие
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
                      Text(
                        "Зарегистрируйтесь",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const Spacer(),

                // if (state is AuthLoading)
                //   const CircularProgressIndicator()
                // else
                //   ElevatedButton(
                //     onPressed: () {
                //       context.read<AuthBloc>().add(
                //         LoginButtonPressed(
                //           email: _emailController.text,
                //           password: _passwordController.text,
                //         ),
                //       );
                //     },
                //     child: const Text('Продолжить'),
                //   ),
                // TextButton(
                //   onPressed: () {
                //     context.read<AuthBloc>().add(NavigateToRegistration());
                //     Navigator.pushNamed(context, '/register');
                //   },
                //   child: const Text('Зарегистрироваться'),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
