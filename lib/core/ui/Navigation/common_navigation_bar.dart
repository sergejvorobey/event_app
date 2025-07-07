import 'dart:io' show Platform;
import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? previousPageTitle;
  final Color? backgroundColor;

  const CommonNavigationBar({
    super.key,
    required this.title,
    this.previousPageTitle,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoNavigationBar(
        previousPageTitle: previousPageTitle,
        middle: Text(title),
        border: null,
        backgroundColor: backgroundColor ?? AppColors.background,
      );
    } else {
      return AppBar(
        title: Text(title),
        backgroundColor: backgroundColor ?? AppColors.background,
        elevation: 0,
      );
    }
  }

  @override
  Size get preferredSize {
    if (Platform.isIOS) {
      return const Size.fromHeight(44.0);
    } else {
      return const Size.fromHeight(kToolbarHeight);
    }
  }
}
