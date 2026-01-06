import 'package:auto_route/auto_route.dart';
import 'package:event_app/core/ui/common_button.dart';
import 'package:event_app/core/ui/common_loading_indicator.dart';
import 'package:event_app/core/ui/common_text_field.dart';
import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:event_app/core/ui/widgets/top_toast.dart';
import 'package:event_app/features/support/city/model/city.dart';
import 'package:event_app/features/user/editProfile/bloc/editprofile_bloc.dart';
import 'package:event_app/routers/routers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final EditprofileBloc _editProfileBloc = EditprofileBloc();
  final FocusNode _firstNameTextFieldFocusNode = FocusNode();
  final FocusNode _lastNameTextFieldFocusNode = FocusNode();
  final FocusNode _birthdayTextFieldFocusNode = FocusNode();
  final FocusNode _cityTextFieldFocusNode = FocusNode();
  final FocusNode _phoneTextFieldFocusNode = FocusNode();
  final FocusNode _telegramTextFieldFocusNode = FocusNode();
  final FocusNode _maxTextFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _editProfileBloc.add(FetchProfile());
  }

  @override
  void dispose() {
    super.dispose();
    _editProfileBloc.close();
    _firstNameTextFieldFocusNode.dispose();
    _lastNameTextFieldFocusNode.dispose();
    _birthdayTextFieldFocusNode.dispose();
    _cityTextFieldFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        previousPageTitle: "Назад",
        middle: const Text('Личные данные'),
        border: null,
        backgroundColor: AppColors.background,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: BlocConsumer<EditprofileBloc, EditprofileState>(
        bloc: _editProfileBloc,
        listener: (context, state) {
          switch (state) {
            case EditprofileNotification(
              :final type,
              :final title,
              :final message,
            ):
              showToast(title: title, message: message, type: type);
              break;
            case ShowEmptyStateScreen(
              title: final title,
              subtitle: final subtitle,
              actionTitle: final actionTitle,
            ):
              AutoRouter.of(context).push(
                CommonEmptyStateRoute(
                  title: title,
                  subtitle: subtitle,
                  actionTitle: actionTitle,
                  closeAction: () {
                    AutoRouter.of(context).pop();
                    AutoRouter.of(context).pop();
                  },
                  action: () {
                    AutoRouter.of(context).pop();
                    _editProfileBloc.add(FetchProfile());
                  },
                ),
              );
              break;
          }
        },
        builder: (context, state) {
          switch (state) {
            case EditprofileLoading():
              return Scaffold(body: makeCommonLoadingIndicator());
            case EditprofileContent():
              return Scaffold(
                body: _makeTextFields(state),
                bottomNavigationBar: _makeSaveButton(state),
              );
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _makeTextFields(EditprofileContent state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          CommonTextField(
            value: state.firstName.value,
            label: state.firstName.label,
            placeholder: state.firstName.placeholder,
            hint: state.firstName.message,
            onValueChanged: _onFirstNameTextChanged,
            hintColor: Colors.grey,
            focusNode: _firstNameTextFieldFocusNode,
          ),
          CommonTextField(
            value: state.lastName.value,
            label: state.lastName.label,
            placeholder: state.lastName.placeholder,
            hint: state.lastName.message,
            onValueChanged: _onLastNameTextChanged,
            hintColor: Colors.grey,
            focusNode: _lastNameTextFieldFocusNode,
          ),
          CommonTextField(
            value: state.birthday.value,
            label: state.birthday.label,
            placeholder: state.birthday.placeholder,
            hint: state.birthday.message,
            onValueChanged: (_) {},
            rightIcon: CupertinoIcons.chevron_right,
            hintColor: Colors.grey,
            focusNode: _birthdayTextFieldFocusNode,
            onTap: () async {
              // final selectedCity = await AutoRouter.of(
              //   context,
              // ).push<City>(CityRoute(selectedCityTitle: state.city.value));

              // if (selectedCity != null && mounted) {
              //   _editProfileBloc.add(CityChanged(selectedCity.title));
              // }
            },
          ),
          CommonTextField(
            value: state.city.value,
            label: state.city.label,
            placeholder: state.city.placeholder,
            hint: state.city.message,
            onValueChanged: (_) {},
            rightIcon: CupertinoIcons.chevron_right,
            focusNode: _cityTextFieldFocusNode,
            onTap: () async {
              final selectedCity = await AutoRouter.of(
                context,
              ).push<City>(CityRoute(selectedCityTitle: state.city.value));

              if (selectedCity != null && mounted) {
                _editProfileBloc.add(CityChanged(selectedCity.title));
              }
            },
          ),
          CommonTextField(
            value: state.phone.value,
            label: state.phone.label,
            placeholder: state.phone.placeholder,
            hint: state.phone.message,
            onValueChanged: (_) {},
            rightIcon: CupertinoIcons.chevron_right,
            hintColor: Colors.grey,
            focusNode: _phoneTextFieldFocusNode,
            onTap: () {},
          ),
          CommonTextField(
            value: state.telegram.value,
            label: state.telegram.label,
            placeholder: state.telegram.placeholder,
            hint: state.telegram.message,
            onValueChanged: (_) {},
            rightIcon: CupertinoIcons.chevron_right,
            hintColor: Colors.grey,
            focusNode: _telegramTextFieldFocusNode,
            onTap: () {},
          ),
          CommonTextField(
            value: state.max.value,
            label: state.max.label,
            placeholder: state.max.placeholder,
            hint: state.max.message,
            onValueChanged: (_) {},
            rightIcon: CupertinoIcons.chevron_right,
            hintColor: Colors.grey,
            focusNode: _maxTextFieldFocusNode,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _makeSaveButton(EditprofileContent state) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        child: CommonButton(
          title: state.saveButton.title,
          isShowIndicator: state.saveButton.isStartActivityIndicator,
          isEnabled: state.saveButton.isEnabled,
          action: () {
            // _editProfileBloc.add(
            //   SaveButtonPressed(
            //     firstName: state.firstName.value,
            //     lastName: state.lastName.value,
            //     email: state.email.value,
            //   ),
            // );
          },
        ),
      ),
    );
  }

  void _onFirstNameTextChanged(String value) {
    _editProfileBloc.add(FirstNameChanged(value));
  }

  void _onLastNameTextChanged(String value) {
    _editProfileBloc.add(LastNameChanged(value));
  }

  void _onBirthdayTextChanged(String value) {
    // _editProfileBloc.add(EmailChanged(value));
  }
}
