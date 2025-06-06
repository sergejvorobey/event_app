import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

Widget makeCommonLoadingIndicator() {
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
      strokeWidth: 3.0,
      strokeAlign: -3.0,
    ),
  );
}
