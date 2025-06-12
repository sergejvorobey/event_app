import 'package:auto_route/auto_route.dart';
import 'package:event_app/core/navigation/route_observer.dart';
import 'package:event_app/core/ui/common_empty_state_screen.dart';
import 'package:event_app/core/ui/common_loading_indicator.dart';
import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:event_app/core/ui/theme/app_text_styles.dart';
import 'package:event_app/features/profile/bloc/profile_bloc.dart';
import 'package:event_app/routers/routers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with RouteAware {
  bool _isRatingPressed = false;
  bool _isReviewsPressed = false;
  bool _isAddProfileImagePressed = false;
  final Set<int> _pressedIndexes = {};

  final ProfileBloc _profileBloc = ProfileBloc();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void initState() {
    super.initState();
    _profileBloc.add(FetchProfile());
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _profileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: BlocConsumer<ProfileBloc, ProfileState>(
          bloc: _profileBloc,
          listener: (context, state) {
            switch (state) {
              case NavigateToEditProfileScreen():
                AutoRouter.of(context).push(EditProfileRoute()).then((_) {
                  _profileBloc.add(FetchProfile());
                });
                break;
              case NavigateToEmptyStateScreen(
                title: final title,
                subtitle: final subtitle,
                actionTitle: final actionTitle,
              ):
                AutoRouter.of(context).push(
                  CommonEmptyStateRoute(
                    title: title,
                    subtitle: subtitle,
                    actionTitle: actionTitle,
                    action: () {
                      AutoRouter.of(context).pop();
                    },
                  ),
                ).then((_) {
                  _profileBloc.add(FetchProfile());
                });
                break;
            }
          },
          builder: (BuildContext context, ProfileState state) {
            switch (state) {
              case ProfileLoading():
                return makeCommonLoadingIndicator();
              case ProfileContent():
                return _content(state);
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget _content(ProfileContent state) {
    final fullName =
        (state.firstName.isEmpty && state.lastName.isEmpty)
            ? state.login
            : "${state.firstName} ${state.lastName}";
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: AppColors.greyDark,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 124),
                _makeProfileImage(state),
                const SizedBox(height: 16),
                Text(
                  fullName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(state.city, style: AppTextStyles.textSecondary16Grey),
                const SizedBox(height: 16),
                _makeRating(),
                const SizedBox(height: 16),
              ],
            ),
          ),

          // Нижняя половина
          _makeProfileMenuV2(state),
        ],
      ),
    );
  }

  Widget _makeProfileImage(ProfileContent state) {
    final String firstChar =
        (state.firstName.isNotEmpty) ? state.firstName[0] : "A";
    final String lastChar =
        (state.lastName.isNotEmpty) ? state.lastName[0] : "B";
    return Stack(
      alignment: Alignment.center,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.background,
                shape: BoxShape.circle,
              ),
            ),
            GestureDetector(
              onTapDown: (_) => _onTapPhoto(true),
              onTapUp: (_) => _onTapPhoto(false),
              onTapCancel: () => _onTapPhoto(false),
              onTap: () {
                // TODO: - Действие при нажатии на блок "Фото"
                print('Нажат блок Фото');
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                transform:
                    Matrix4.identity()
                      ..scale(_isAddProfileImagePressed ? 0.95 : 1.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Icon(
                      CupertinoIcons.camera_fill,
                      color: AppColors.background,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Text(
          "$firstChar$lastChar",
          style: AppTextStyles.headline16,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _makeRating() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background.withAlpha(30),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        spacing: 4,
        children: [
          const SizedBox(width: 0),
          // Рейтинг
          Expanded(
            child: GestureDetector(
              onTapDown: (_) => _onTapRating(true),
              onTapUp: (_) => _onTapRating(false),
              onTapCancel: () => _onTapRating(false),
              onTap: () {
                // TODO: - Действие при нажатии на блок "Рейтинг"
                print('Нажат блок Рейтинг');
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                transform:
                    Matrix4.identity()..scale(_isRatingPressed ? 0.95 : 1.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: const [
                    Text('Рейтинг', style: AppTextStyles.textSecondary14White),
                    Text('0.0', style: AppTextStyles.headline16White),
                  ],
                ),
              ),
            ),
          ),
          // Вертикальный Divider
          Container(
            width: 0.5,
            height: 36,
            color: AppColors.background.withAlpha(100),
          ),
          const SizedBox(width: 8),
          // Отзывы
          Expanded(
            child: GestureDetector(
              onTapDown: (_) => _onTapReviews(true),
              onTapUp: (_) => _onTapReviews(false),
              onTapCancel: () => _onTapReviews(false),
              onTap: () {
                // TODO: - Действие при нажатии на блок "Отзыв"
                print('Нажат блок Отзывы');
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                transform:
                    Matrix4.identity()..scale(_isReviewsPressed ? 0.95 : 1.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: const [
                    Text('Отзывы', style: AppTextStyles.textSecondary14White),
                    Text('Нет отзывов', style: AppTextStyles.headline16White),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _makeProfileMenu(ProfileContent state) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 12),
          for (int i = 0; i < state.menu.length; i++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: GestureDetector(
                onTapDown: (_) {
                  setState(() {
                    _pressedIndexes.add(i);
                  });
                },
                onTapUp: (_) {
                  setState(() {
                    _pressedIndexes.remove(i);
                  });
                },
                onTapCancel: () {
                  setState(() {
                    _pressedIndexes.remove(i);
                  });
                },
                onTap: () {
                  _profileBloc.add(ItemMenuProfilePressed(index: i));
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  transform:
                      Matrix4.identity()
                        ..scale(_pressedIndexes.contains(i) ? 0.95 : 1.0),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundSecondary.withAlpha(10),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(40),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            state.menu[i].icon,
                            size: 16,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        spacing: 0,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.menu[i].title,
                            style: AppTextStyles.headline16,
                          ),
                          const SizedBox(height: 4),
                          if (state.menu[i].text.isNotEmpty)
                            Text(
                              state.menu[i].text,
                              style: AppTextStyles.textSecondary12,
                            ),
                        ],
                      ),

                      // Icon(
                      //   CupertinoIcons.chevron_right,
                      //   size: 16,
                      //   color: AppColors.greyDark.withAlpha(100),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _makeProfileMenuV2(ProfileContent state) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: state.menu.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 колонки
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.2,
        ),
        itemBuilder: (context, i) {
          final item = state.menu[i];
          final isPressed = _pressedIndexes.contains(i);

          return GestureDetector(
            onTapDown: (_) => setState(() => _pressedIndexes.add(i)),
            onTapUp: (_) => setState(() => _pressedIndexes.remove(i)),
            onTapCancel: () => setState(() => _pressedIndexes.remove(i)),
            onTap: () => _profileBloc.add(ItemMenuProfilePressed(index: i)),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              transform: Matrix4.identity()..scale(isPressed ? 0.95 : 1.0),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.backgroundSecondary.withAlpha(10),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Верхняя иконка
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(40),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        item.icon,
                        size: 16,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: AppTextStyles.headline16),
                      const SizedBox(height: 4),
                      if (item.text.isNotEmpty)
                        Text(item.text, style: AppTextStyles.textSecondary12),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onTapRating(bool value) {
    setState(() => _isRatingPressed = value);
  }

  void _onTapReviews(bool value) {
    setState(() => _isReviewsPressed = value);
  }

  void _onTapPhoto(bool value) {
    setState(() => _isAddProfileImagePressed = value);
  }
}
