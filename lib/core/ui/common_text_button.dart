import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:event_app/core/ui/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CommonTextButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isEnabled;

  const CommonTextButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isEnabled = true,
  });

  @override
  State<CommonTextButton> createState() => _CommonTextButtonState();
}

final class _CommonTextButtonState extends State<CommonTextButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isEnabled ? widget.onPressed : null,
      onTapDown: (_) => _onPressed(),
      onTapUp: (_) => _onReleased(),
      onTapCancel: _onReleased,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: widget.isEnabled ? (_isPressed ? 0.6 : 1.0) : 0.5,
        child: Text(
          widget.title,
          style: AppTextStyles.button.copyWith(
            color:
                widget.isEnabled ? AppColors.primary : AppColors.textSecondary,
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
