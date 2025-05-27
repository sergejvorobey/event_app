import 'package:event_app/core/ui/common_button.dart';
import 'package:event_app/core/ui/common_text_button.dart';
import 'package:event_app/core/ui/common_text_field.dart';
import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:event_app/core/ui/widgets/common_top_toast_widget.dart';
import 'package:event_app/core/ui/widgets/top_toast.dart';
import 'package:event_app/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/cupertino.dart';
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
  final bool isEnableButton = false;

  final AuthBloc _authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        previousPageTitle: "Назад",
        middle: const Text('Вход'),
        border: null,
        backgroundColor: AppColors.background,
        ),
      body: _content(),
    );
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
            case AuthSuccess(:final userId):
              _authBloc.add(FetchToken(userId: userId));
              break;

            case TokenSuccess():
              Navigator.pushNamed(context, '/home');
              break;

            case AuthError(:final message) || TokenError(:final message):
              showTopToast(
                context: context,
                title: 'Ошибка',
                message: message,
                type: ToastType.error,
              );
              break;
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
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 32),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       Text(
                    //         'Добро пожаловать',
                    //         style: AppTextStyles.headline2,
                    //         textAlign: TextAlign.center,
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 16),
                    //         child: Text(
                    //           'Введите логин и пароль что бы войти',
                    //           style: AppTextStyles.textSecondary16,
                    //           textAlign: TextAlign.center,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // const Spacer(),
                    const SizedBox(height: 16),
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
                    const Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                child: Column(
                  spacing: 16,
                  children: [
                    CommonButton(
                      title: 'Войти',
                      action: () {
                        _authBloc.add(
                          LoginButtonPressed(
                            login: state.login?.value ?? "",
                            password: state.password?.value ?? "",
                          ),
                        );
                      },
                      isEnabled: state.isButtonEnabled,
                      isShowIndicator: state is AuthLoading,
                    ),
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