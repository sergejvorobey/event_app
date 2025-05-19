import 'package:event_app/core/ui/common_button.dart';
import 'package:event_app/core/ui/common_text_button.dart';
import 'package:event_app/core/ui/common_text_field.dart';
import 'package:event_app/core/ui/theme/app_text_styles.dart';
import 'package:event_app/core/ui/widgets/common_top_toast_widget.dart';
import 'package:event_app/core/ui/widgets/top_toast.dart';
import 'package:event_app/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  AuthScreenState createState() => AuthScreenState();
}

// MARK: - Lifecycle

final class AuthScreenState extends State<AuthScreen> {
  
  // MARK: - Property

  final FocusNode _loginTextFieldFocusNode = FocusNode();
  final FocusNode _passwordTextFieldFocusNode = FocusNode();

  final AuthBloc _authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('')), body: _content());
  }

  @override
  void dispose() {
    _authBloc.close();
    _loginTextFieldFocusNode.dispose();
    _passwordTextFieldFocusNode.dispose();
    super.dispose();
  }

  // MARK: - Privates

  Widget _content() {
    return SafeArea(
      child: BlocConsumer<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (context, state) {
          switch (state) {
            case AuthSuccess():
              Navigator.pushNamed(context, '/home');
            case AuthError():
              showTopToast(
                context: context,
                title: 'Ошибка',
                message: state.message,
                type: ToastType.error,
              );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                        value: state.login?.value ?? "",
                        label: state.login?.label ?? "",
                        placeholder: state.login?.placeholder ?? "",
                        hint: state.login?.message ?? "",
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
                        value: state.password?.value ?? "",
                        label: state.password?.label ?? "",
                        placeholder: state.password?.placeholder ?? "",
                        hint: state.password?.message ?? "",
                        onValueChanged: _onPasswordTextChanged,
                        isStartIndicator: false,
                        hintColor: Colors.grey,
                        isSecure: true,
                        focusNode: _passwordTextFieldFocusNode,
                        isShowKeyboard: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                        bottom: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          CommonTextButton(
                            title: "Восстановить пароль",
                            onPressed: () {
                              _authBloc.add(RecoverButtonPressed());
                            },
                            isEnabled: true,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: CommonButton(
                  title: 'Продолжить',
                  isEnabled: true,
                  action: () {
                    _authBloc.add(
                      LoginButtonPressed(
                        login: state.login?.value ?? "",
                        password: state.password?.value ?? "",
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onLoginTextChanged(String value) {
    _authBloc.add(LoginChanged(value));
  }

  void _onPasswordTextChanged(String value) {
    _authBloc.add(PasswordChanged(value));
  }
}