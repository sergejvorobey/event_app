import 'package:event_app/core/ui/widgets/common_top_toast_widget.dart';
import 'package:flutter/material.dart';

void showTopToast({
  required BuildContext context,
  required String title,
  required String message,
  required ToastType type,
}) {
  final overlay = Overlay.of(context);

  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder:
        (context) => CommonTopToastWidget(
          title: title,
          message: message,
          type: type,
          onDismissed: () => overlayEntry.remove(),
        ),
  );

  overlay.insert(overlayEntry);
}
