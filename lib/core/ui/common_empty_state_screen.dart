import 'package:auto_route/auto_route.dart';
import 'package:event_app/core/ui/common_button.dart';
import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:event_app/core/ui/theme/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CommonEmptyStateScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final String actionTitle;
  final VoidCallback action;

  const CommonEmptyStateScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.actionTitle,
    required this.action,
  });

  @override
  CommonEmptyStateScreenState createState() => CommonEmptyStateScreenState();
}

final class CommonEmptyStateScreenState extends State<CommonEmptyStateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 8.0,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(40),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    CupertinoIcons.exclamationmark_triangle_fill,
                    size: 32,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(widget.title, style: AppTextStyles.headline1),
              Text(widget.subtitle, style: AppTextStyles.bodyText1),
              const Spacer(),
              CommonButton(
                title: widget.actionTitle,
                action: widget.action,
                isEnabled: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
