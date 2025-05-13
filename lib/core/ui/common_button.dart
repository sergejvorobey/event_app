import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:event_app/core/ui/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatefulWidget {
  final String title;
  final double height;
  final double horizontalMargin;
  final VoidCallback action;
  final bool isEnabled;
  final bool isShowIndicator;

  const CommonButton({
    super.key,
    required this.title,
    this.height = 52.0,
    this.horizontalMargin = 16.0,
    required this.action,
    this.isEnabled = false,
    this.isShowIndicator = false,
  });

  @override
  CommonButtonState createState() => CommonButtonState();
}

final class CommonButtonState extends State<CommonButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: widget.horizontalMargin),
      child: GestureDetector(
        onTap: widget.isEnabled ? widget.action : null,
        onTapDown: (_) => _onPressed(),
        onTapUp: (_) => _onReleased(),
        onTapCancel: _onReleased,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: _isPressed
                ? AppColors.primary.withAlpha(95)
                : AppColors.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          width: double.infinity,
          height: widget.height,
          alignment: Alignment.center,
          child: widget.isShowIndicator
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 3.0,
                  strokeAlign: -2.0,
                )
              : Text(
                  widget.title,
                  style: AppTextStyles.button
                ),
        ),
      ),
    );
  }

  void _onPressed() {
    setState(() {
      _isPressed = true;
    });
  }

  void _onReleased() {
    setState(() {
      _isPressed = false;
    });
  }
}