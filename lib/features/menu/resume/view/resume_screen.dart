import 'package:event_app/core/ui/common_button.dart';
import 'package:event_app/core/ui/common_loading_indicator.dart';
import 'package:event_app/core/ui/common_modal_sheet.dart';
import 'package:event_app/core/ui/common_text_button.dart';
import 'package:event_app/core/ui/common_text_field.dart';
import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:event_app/core/ui/theme/app_text_styles.dart';
import 'package:event_app/core/ui/widgets/top_toast.dart';
import 'package:event_app/features/menu/resume/bloc/resume_bloc.dart';
import 'package:event_app/features/menu/resume/view/contact_cell.dart';
import 'package:event_app/routers/routers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class ResumeScreen extends StatefulWidget {
  const ResumeScreen({super.key});

  @override
  State<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  final FocusNode _professionextFieldFocusNode = FocusNode();

  final ResumeBloc _resumeBloc = ResumeBloc();
  bool _isPresonalDataPressed = false;

  @override
  void initState() {
    super.initState();
    _resumeBloc.add(FetchProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        previousPageTitle: "Назад",
        middle: const Text('Профиль соискателя'),
        border: null,
        backgroundColor: AppColors.background,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: BlocConsumer<ResumeBloc, ResumeState>(
        bloc: _resumeBloc,
        listener: (context, state) {
          switch (state) {
            case ShowEditProfileScreen():
              AutoRouter.of(context).push(EditProfileRoute()).then((_) {
                _resumeBloc.add(FetchProfile());
              });
            case ShowContactsScreen():
              _showContactsScreen().then((_) {
                _resumeBloc.add(FetchProfile());
              });
            case ResumeNotification(:final type, :final title, :final message):
              showToast(title: title, message: message, type: type);
          }
        },
        builder: (context, state) {
          switch (state) {
            case ResumeLoading():
              return Scaffold(body: makeCommonLoadingIndicator());
            case ResumeContent():
              return Scaffold(body: _makeContent(state));
            case ResumeError():
              return SizedBox.shrink();
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _makeContent(ResumeContent state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        spacing: 0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _makePersonalData(state),
          const SizedBox(height: 32),

          _makeContactsV2(state),
          const SizedBox(height: 32),

          _makeProfessionV2(state),
          const SizedBox(height: 8),

          _makeAbout(state),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _makePersonalData(ResumeContent state) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPresonalDataPressed = true),
        onTapUp: (_) {
          setState(() => _isPresonalDataPressed = false);
          _resumeBloc.add(NavigateToEditProfileScreen());
        },
        onTapCancel: () => setState(() => _isPresonalDataPressed = false),
        child: Column(
          children: [
            Row(
              spacing: 0,
              children: [
                _makeSectionTitle("Личные данные"),
                const Spacer(),
                // Padding(
                //   padding: const EdgeInsets.only(right: 0),
                //   child: CupertinoButton(
                //     padding: EdgeInsets.zero,
                //     minimumSize: Size.zero,
                //     child: Icon(CupertinoIcons.ellipsis_vertical, size: 21),
                //     onPressed: () {
                //       _resumeBloc.add(NavigateToEditProfileScreen());
                //     },
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 16),
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              transform:
                  Matrix4.identity()
                    ..scale(_isPresonalDataPressed ? 0.96 : 1.0),
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 12,
                bottom: 12,
              ),
              decoration: BoxDecoration(
                color: AppColors.greyLight.withAlpha(150),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _makeProfileImage(state),
                  const SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (state.firstName.value.isEmpty &&
                              state.lastName.value.isEmpty)
                            Text(
                              state.login.value,
                              style: AppTextStyles.headline16,
                            )
                          else
                            Text(
                              state.firstName.value,
                              style: AppTextStyles.headline16,
                            ),
                          const SizedBox(width: 4),
                          Text(
                            state.lastName.value,
                            style: AppTextStyles.headline16,
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        state.city.value,
                        style: AppTextStyles.textSecondary14,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    CupertinoIcons.chevron_right,
                    size: 12,
                    color: AppColors.greyDark.withAlpha(150),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _makeProfileImage(ResumeContent state) {
    final String firstChar =
        (state.firstName.value.isNotEmpty)
            ? state.firstName.value[0]
            : state.email.value[0];
    final String lastChar =
        (state.lastName.value.isNotEmpty)
            ? state.lastName.value[0]
            : state.email.value[0];
    return Stack(
      alignment: Alignment.center,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.textWhite,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        Text(
          "$firstChar$lastChar",
          style: AppTextStyles.headline12,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _makeContactsV2(ResumeContent state) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: AppColors.greyLight.withAlpha(0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          spacing: 16,
          children: [
            Row(
              spacing: 0,
              children: [
                _makeSectionTitle("Контакты"),
                const Spacer(),
                // Padding(
                //   padding: const EdgeInsets.only(right: 0),
                //   child: CupertinoButton(
                //     padding: EdgeInsets.zero,
                //     minimumSize: Size.zero,
                //     child: Icon(CupertinoIcons.ellipsis_vertical, size: 21),
                //     onPressed: () {
                //       _resumeBloc.add(NavigateToContactsScreen());
                //     },
                //   ),
                // ),
              ],
            ),
            Row(
              spacing: 16,
              children: [
                Expanded(
                  child: ContactCell(
                    icon: Icons.phone,
                    title: state.phoneNumber.label,
                    value: state.phoneNumber.value,
                    onTap: () => _resumeBloc.add(NavigateToContactsScreen()),
                  ),
                ),
                Expanded(
                  child: ContactCell(
                    icon: Icons.email,
                    title: state.email.label,
                    value: state.email.value,
                    onTap: () => _resumeBloc.add(NavigateToContactsScreen()),
                  ),
                ),
              ],
            ),
            Row(
              spacing: 16,
              children: [
                Expanded(
                  child: ContactCell(
                    icon: ImageIcon(
                      AssetImage('assets/icons/telegram.png'),
                      size: 18,
                      color: AppColors.primary,
                    ),
                    title: state.telegram.label,
                    value: state.telegram.value,
                    onTap: () => _resumeBloc.add(NavigateToContactsScreen()),
                  ),
                ),
                Expanded(
                  child: ContactCell(
                    // icon: ImageIcon(
                    //   AssetImage('assets/icons/max.png'),
                    //   size: 18,
                    //   color: AppColors.primary,
                    // ),
                    icon: Icons.send,
                    title: state.max.label,
                    value: state.max.value,
                    onTap: () => _resumeBloc.add(NavigateToContactsScreen()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _makeProfessionV2(ResumeContent state) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: AppColors.greyLight.withAlpha(0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          spacing: 8,
          children: [
            Row(
              spacing: 0,
              children: [
                _makeSectionTitle("Профессия"),
                const Spacer(),
                // Padding(
                //   padding: const EdgeInsets.only(right: 0),
                //   child: CupertinoButton(
                //     padding: EdgeInsets.zero,
                //     minimumSize: Size.zero,
                //     child: Icon(CupertinoIcons.ellipsis_vertical, size: 21),
                //     onPressed: () => {},
                //   ),
                // ),
              ],
            ),
            CommonTextField(
              value: state.profession.value,
              label: state.profession.label,
              placeholder: state.profession.placeholder,
              hint: state.profession.message,
              onValueChanged: (_) {},
              focusNode: _professionextFieldFocusNode,
              rightIcon: CupertinoIcons.chevron_right,
              rightIconSize: 12,
              onTap: () async {
                // final selectedCity = await AutoRouter.of(
                //   context,
                // ).push<City>(CityRoute(selectedCityTitle: state.city.value));

                // if (selectedCity != null && mounted) {
                //   _editProfileBloc.add(CityChanged(selectedCity.title));
                // }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _makeProfession(ResumeContent state) {
    return CommonTextField(
      value: state.profession.value,
      label: state.profession.label,
      placeholder: state.profession.placeholder,
      hint: state.profession.message,
      onValueChanged: (_) {},
      focusNode: _professionextFieldFocusNode,
      rightIcon: CupertinoIcons.chevron_right,
      rightIconSize: 12,
      onTap: () async {
        // final selectedCity = await AutoRouter.of(
        //   context,
        // ).push<City>(CityRoute(selectedCityTitle: state.city.value));

        // if (selectedCity != null && mounted) {
        //   _editProfileBloc.add(CityChanged(selectedCity.title));
        // }
      },
    );
  }

  Widget _makeAbout(ResumeContent state) {
    return Column(
      spacing: 0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _makeSectionTitle("О себе"),
        const SizedBox(height: 8),
        CommonTextButton(title: "Добавить о себе", onPressed: () => {}),
      ],
    );
  }

  Widget _makeSaveButton(ResumeContent state) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        child: CommonButton(
          title: state.saveButton.title,
          isShowIndicator: state.saveButton.isStartActivityIndicator,
          isEnabled: state.saveButton.isEnabled,
          action: () {
            _resumeBloc.add(
              SaveButtonPressed(
                firstName: state.firstName.value,
                lastName: state.lastName.value,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _makeSectionTitle(String title) {
    return Column(children: [Text(title, style: AppTextStyles.headline21)]);
  }

  Future<void> _showContactsScreen() {
    return showCupertinoModalPopup(
      context: context,
      builder:
          (_) => CommonModalSheetScreen(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      CommonTextButton(
                        title: "Закрыть",
                        onPressed: () {
                          AutoRouter.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Text("Контакты", style: AppTextStyles.headline1),
                  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        CommonTextField(
                          value: "",
                          label: "Номер телефона",
                          placeholder: "Номере телефона",
                          hint: "",
                          onValueChanged: (v) {},
                        ),
                        CommonTextField(
                          value: "",
                          label: "Номер телефона",
                          placeholder: "Номере телефона",
                          hint: "",
                          onValueChanged: (v) {},
                        ),
                        CommonTextField(
                          value: "",
                          label: "Номер телефона",
                          placeholder: "Номере телефона",
                          hint: "",
                          onValueChanged: (v) {},
                        ),
                        CommonTextField(
                          value: "",
                          label: "Номер телефона",
                          placeholder: "Номере телефона",
                          hint: "",
                          onValueChanged: (v) {},
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  CommonButton(title: 'Сохранить', action: () {}),
                ],
              ),
            ),
          ),
    );
  }

  void _onModalTextFieldChanged(String value) {}

  void _onFirstNameTextChanged(String value) {
    // _editProfileBloc.add(FirstNameChanged(value));
  }

  void _onLastNameTextChanged(String value) {
    // _editProfileBloc.add(LastNameChanged(value));
  }

  void _onEmailTextChanged(String value) {
    // _editProfileBloc.add(EmailChanged(value));
  }

  void _onPhoneNumberTextChanged(String value) {
    // _editProfileBloc.add(EmailChanged(value));
  }

  void _onTelegramTextChanged(String value) {
    // _editProfileBloc.add(EmailChanged(value));
  }
}
