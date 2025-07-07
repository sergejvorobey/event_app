import 'package:event_app/core/ui/widgets/common_top_toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

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

void showToast({
  required String title,
  required String message,
  required ToastType type
}) {
  toastification.show(
    title: Text(title),
    description: Text(message),
    type: _makeToastType(type),
    style: ToastificationStyle.flat,
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [],
    autoCloseDuration: const Duration(seconds: 2),
    alignment: Alignment.topCenter
  );
}

ToastificationType _makeToastType(ToastType type) {
  switch (type) {
    case ToastType.error:
      return ToastificationType.error;
    case ToastType.warning:
      return ToastificationType.warning;
    case ToastType.success:
      return ToastificationType.success;
    case ToastType.info:
      return ToastificationType.info;
  }
}
