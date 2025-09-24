import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  // Заголовки
  static const TextStyle headline1 = TextStyle(
    fontSize: 28,
    fontFamily: 'SFRounded',
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 22,
    fontFamily: 'SFRounded',
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle headline21 = TextStyle(
    fontSize: 21,
    fontFamily: 'SFRounded',
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle headline16 = TextStyle(
    fontSize: 16,
    fontFamily: 'SFRounded',
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

    static const TextStyle headline12 = TextStyle(
    fontSize: 12,
    fontFamily: 'SFRounded',
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle headline16White = TextStyle(
    fontSize: 16,
    fontFamily: 'SFRounded',
    fontWeight: FontWeight.w600,
    color: AppColors.textWhite,
  );

  // Основной текст
  static const TextStyle bodyText1 = TextStyle(
    fontSize: 16,
    fontFamily: 'SFRounded',
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyText2 = TextStyle(
    fontSize: 14,
    fontFamily: 'SFRounded',
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static const TextStyle bodyText12 = TextStyle(
    fontSize: 12,
    fontFamily: 'SFRounded',
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static const TextStyle bodyText14 = TextStyle(
    fontSize: 16,
    fontFamily: 'SFRounded',
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static const TextStyle textSecondary12 = TextStyle(
    fontSize: 12,
    fontFamily: 'SFRounded',
    color: AppColors.textSecondary,
  );

  static const TextStyle textSecondary14White = TextStyle(
    fontSize: 14,
    fontFamily: 'SFRounded',
    color: AppColors.textWhite,
  );

  static const TextStyle textSecondary16Grey = TextStyle(
    fontSize: 16,
    fontFamily: 'SFRounded',
    color: AppColors.textWhite,
  );

  static const TextStyle textSecondary14 = TextStyle(
    fontSize: 14,
    fontFamily: 'SFRounded',
    color: AppColors.textSecondary,
  );

  static const TextStyle textSecondary16 = TextStyle(
    fontSize: 16,
    fontFamily: 'SFRounded',
    color: AppColors.textSecondary,
  );

  // Кнопки
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontFamily: 'SFRounded',
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  // Поля ввода
  static const TextStyle inputText = TextStyle(
    fontSize: 16,
    fontFamily: 'SFRounded',
    color: AppColors.textPrimary,
  );

  static const TextStyle navigationText = TextStyle(
    fontSize: 16,
    fontFamily: 'SFRounded',
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle navigationAction = TextStyle(
    fontSize: 16,
    fontFamily: 'SFRounded',
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
  );
}
