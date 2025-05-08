import 'package:event_app/core/ui/theme/app_colors.dart';
import 'package:event_app/core/ui/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  final String value;
  final TextStyle style;
  final Alignment textAlignment;
  final String label;
  final String placeholder;
  final String? hint;
  final Color borderColor;
  final bool isEnabled;
  final int textLimit;
  final ValueChanged<String> onValueChanged;
  final bool isStartIndicator;
  final Color hintColor;
  final bool isSecure;
  final IconData? rightIcon;
  final VoidCallback? onTapRightIcon;
  final FocusNode? focusNode;
  final bool isShowKeyboard;

  const CommonTextField({
    super.key,
    this.value = '',
    this.style = const TextStyle(fontSize: 16, color: Colors.black),
    this.textAlignment = Alignment.centerLeft,
    required this.label,
    required this.placeholder,
    this.hint,
    this.borderColor = Colors.grey,
    this.isEnabled = true,
    this.textLimit = 50,
    required this.onValueChanged,
    this.isStartIndicator = false,
    this.hintColor = Colors.grey,
    this.isSecure = false,
    this.rightIcon,
    this.onTapRightIcon,
    this.focusNode,
    this.isShowKeyboard = false,
  });

  @override
  CommonTextFieldState createState() => CommonTextFieldState();
}

final class CommonTextFieldState extends State<CommonTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  Color _currentLabelColor = Colors.grey;
  Color _currentBackgroundColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focusNode = widget.focusNode ?? FocusNode();

    if (widget.isShowKeyboard) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(_focusNode);
      });
    }

    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    final primaryColor = AppColors.primary;
    final backgroundColor = primaryColor.withValues(
      alpha: (primaryColor.a * 0.1).toDouble(),
      red: primaryColor.r.toDouble(),
      green: primaryColor.g.toDouble(),
      blue: primaryColor.b.toDouble(),
    );

    setState(() {
      _currentLabelColor = _focusNode.hasFocus ? primaryColor : AppColors.textSecondary;
      _currentBackgroundColor =
          _focusNode.hasFocus ? backgroundColor : AppColors.greyLight;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.removeListener(_handleFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(CommonTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text) {
      _controller.text = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 8),
        Container(
          height: 64,
          decoration: BoxDecoration(
            color: _currentBackgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              if (widget.isStartIndicator)
                Positioned(
                  right: 16,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.label,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "SFRounded",
                              color: _currentLabelColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          TextField(
                            controller: _controller,
                            focusNode: _focusNode,
                            enabled: widget.isEnabled,
                            obscureText: widget.isSecure,
                            style: widget.style,
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              fillColor: Colors.white.withAlpha(0),
                              hintText:
                                  _controller.text.isEmpty
                                      ? widget.placeholder
                                      : null,
                              hintStyle: AppTextStyles.textSecondary16
                            ),
                            textAlign: _getTextAlign(),
                            onChanged: _handleTextChanged,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (widget.rightIcon != null)
                    GestureDetector(
                      onTap: widget.onTapRightIcon,
                      child: Icon(
                        widget.rightIcon,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        if (widget.hint != null) ...[
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.hint!,
              style: AppTextStyles.textSecondary12
            ),
          ),
        ],
      ],
    );
  }

  void _handleTextChanged(String value) {
    if (value.length <= widget.textLimit) {
      widget.onValueChanged(value);
    } else {
      _controller.text = value.substring(0, widget.textLimit);
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }
  }

  TextAlign _getTextAlign() {
    if (widget.textAlignment == Alignment.center) {
      return TextAlign.center;
    } else if (widget.textAlignment == Alignment.centerLeft) {
      return TextAlign.left;
    } else if (widget.textAlignment == Alignment.centerRight) {
      return TextAlign.right;
    }
    return TextAlign.left;
  }
}