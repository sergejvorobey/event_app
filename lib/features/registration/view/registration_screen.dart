import 'package:event_app/core/ui/common_button.dart';
import 'package:event_app/core/ui/common_text_field.dart';
import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:event_app/core/ui/theme/app_text_styles.dart';
import 'package:event_app/features/registration/bloc/registration_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _regBloc = RegistrationBloc();
  final FocusNode _loginTextFieldFocusNode = FocusNode();
  final FocusNode _passwordTextFieldFocusNode = FocusNode();
  final FocusNode _confirmPasswordTextFieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        previousPageTitle: "Назад",
        middle: const Text('Регистрация'),
        backgroundColor: AppColors.background,
        ),
      body: _content(),
    );
  }

  Widget _content() {
    return SafeArea(
      child: BlocConsumer<RegistrationBloc, RegistrationState>(
        bloc: _regBloc,
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          CommonTextField(
                            value: "",
                            label: "Логин",
                            placeholder: "Введите логин",
                            hint: "Начните вводить логин",
                            onValueChanged: _onLoginTextChanged,
                            isStartIndicator: false,
                            hintColor: Colors.grey,
                            isSecure: false,
                            focusNode: _loginTextFieldFocusNode,
                            isShowKeyboard: true,
                          ),
                          CommonTextField(
                              value: "",
                              label: "Пароль",
                              placeholder: "Введите пароль",
                              hint: "Начните вводить пароль",
                              onValueChanged: _onPasswordTextChanged,
                              isStartIndicator: false,
                              hintColor: Colors.grey,
                              isSecure: true,
                              focusNode: _passwordTextFieldFocusNode,
                              isShowKeyboard: false,
                            ),
                            CommonTextField(
                              value: "",
                              label: "Повторите пароль",
                              placeholder: "Введите пароль",
                              hint: "Начните вводить пароль",
                              onValueChanged: _onConfirmPasswordTextChanged,
                              isStartIndicator: false,
                              hintColor: Colors.grey,
                              isSecure: true,
                              focusNode: _confirmPasswordTextFieldFocusNode,
                              isShowKeyboard: false,
                            ),
                          ],
                        ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      child: CommonButton(
                        title: 'Продолжить',
                        isEnabled: true,
                        action: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onLoginTextChanged(String value) {
    // _authBloc.add(LoginChanged(value));
  }

  void _onPasswordTextChanged(String value) {
    // _authBloc.add(LoginChanged(value));
  }

  void _onConfirmPasswordTextChanged(String value) {
    // _authBloc.add(LoginChanged(value));
  }
}
