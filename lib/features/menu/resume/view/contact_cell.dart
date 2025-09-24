import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:event_app/core/ui/theme/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactCell extends StatefulWidget {
  final dynamic icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const ContactCell({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  State<ContactCell> createState() => _ContactCellState();
}

class _ContactCellState extends State<ContactCell> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    Widget iconWidget;

    if (widget.icon is IconData) {
      iconWidget = Icon(widget.icon, size: 18, color: AppColors.primary);
    } else if (widget.icon is Widget) {
      iconWidget = widget.icon;
    } else {
      throw ArgumentError('icon должен быть IconData или Widget');
    }

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: Matrix4.identity()..scale(_isPressed ? 0.96 : 1.0),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.greyLight.withAlpha(150),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(40),
                  shape: BoxShape.circle,
                ),
                child: Center(child: iconWidget),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: AppTextStyles.textSecondary14),
                  Text(widget.value, style: AppTextStyles.headline12),
                ],
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}