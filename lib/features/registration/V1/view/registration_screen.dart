import 'package:auto_route/auto_route.dart';
import 'package:event_app/core/ui/common_button.dart';
import 'package:event_app/core/ui/common_text_field.dart';
import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:event_app/core/ui/widgets/common_top_toast_widget.dart';
import 'package:event_app/core/ui/widgets/top_toast.dart';
import 'package:event_app/features/registration/V1/bloc/registration_bloc.dart';
import 'package:event_app/routers/routers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
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
  bool _isSecurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        previousPageTitle: "Назад",
        middle: const Text('Регистрация'),
        border: null,
        backgroundColor: AppColors.background,
      ),
      body: _content(),
    );
  }

  Widget _content() {
    return SafeArea(
      child: BlocConsumer<RegistrationBloc, RegistrationState>(
        bloc: _regBloc,
        listener: (context, state) {
          switch (state) {
            case RegistrationSuccess(:final userId):
              _regBloc.add(FetchToken(userId: userId));
              break;

            case TokenSuccess():
              AutoRouter.of(context).push(HomeRoute());
              break;

            case RegistrationError(:final message) ||
                TokenError(:final message):
              showToast(
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
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          CommonTextField(
                            value: state.login?.value ?? "",
                            label: state.login?.label ?? "",
                            placeholder: state.login?.placeholder ?? "",
                            hint: state.login?.message ?? "",
                            onValueChanged: _onLoginTextChanged,
                            hintColor: Colors.grey,
                            focusNode: _loginTextFieldFocusNode,
                            isFocused: true,
                          ),
                          CommonTextField(
                            value: state.password?.value ?? "",
                            label: state.password?.label ?? "",
                            placeholder: state.password?.placeholder ?? "",
                            hint: state.password?.message ?? "",
                            onValueChanged: _onPasswordTextChanged,
                            hintColor: Colors.grey,
                            isSecure: _isSecurePassword,
                            focusNode: _passwordTextFieldFocusNode,
                            rightIcon: CupertinoIcons.eye_fill,
                            onTapRightIcon: () {
                              _onTapSecure();
                            },
                          ),
                          CommonTextField(
                            value: state.confirmPassword?.value ?? "",
                            label: state.confirmPassword?.label ?? "",
                            placeholder:
                                state.confirmPassword?.placeholder ?? "",
                            hint: state.confirmPassword?.message ?? "",
                            onValueChanged: _onConfirmPasswordTextChanged,
                            hintColor: Colors.grey,
                            isSecure: _isSecurePassword,
                            focusNode: _confirmPasswordTextFieldFocusNode,
                            rightIcon: CupertinoIcons.eye_fill,
                            onTapRightIcon: () {
                              _onTapSecure();
                            },
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
                        action: () {
                          _regBloc.add(
                            RegistrationButtonPressed(
                              login: state.login?.value ?? "",
                              password: state.password?.value ?? "",
                            ),
                          );
                        },
                        isEnabled: state.isButtonEnabled,
                        isShowIndicator: state is RegistrationLoading,
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
    _regBloc.add(LoginChanged(value));
  }

  void _onPasswordTextChanged(String value) {
    _regBloc.add(PasswordChanged(value));
  }

  void _onConfirmPasswordTextChanged(String value) {
    _regBloc.add(ConfirmPasswordChanged(value));
  }

  void _onTapSecure() {
    setState(() {
      _isSecurePassword = !_isSecurePassword;
    });
  }
}