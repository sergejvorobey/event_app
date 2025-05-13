import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum ToastType { error, warning, success, info }

extension ToastTypeExtension on ToastType {
  Color get backgroundColor {
    switch (this) {
      case ToastType.error:
        return Colors.red.withAlpha(999);
      case ToastType.warning:
        return Colors.orange.withAlpha(999);
      case ToastType.success:
        return Colors.green.withAlpha(999);
      case ToastType.info:
        return Colors.blue.withAlpha(999);
    }
  }
}

class CommonTopToastWidget extends StatefulWidget {
  final String title;
  final String message;
  final ToastType type;
  final VoidCallback onDismissed;

  const CommonTopToastWidget({
    super.key,
    required this.title,
    required this.message,
    required this.type,
    required this.onDismissed,
  });

  @override
  State<CommonTopToastWidget> createState() => _CommonTopToastWidgetState();
}

class _CommonTopToastWidgetState extends State<CommonTopToastWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    // Ждём 2 секунды, потом проигрываем обратную анимацию и удаляем
    Future.delayed(const Duration(seconds: 2), () async {
      await _controller.reverse();
      widget.onDismissed();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double get topPadding => MediaQuery.of(context).padding.top + kToolbarHeight;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SlideTransition(
        position: _animation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.fromLTRB(16, topPadding, 16, 16),
            color: widget.type.backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'SFRounded',
                    fontWeight: FontWeight.bold,
                    color: AppColors.textWhite,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.message,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'SFRounded',
                    fontWeight: FontWeight.w700,
                    color: AppColors.textWhite,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
