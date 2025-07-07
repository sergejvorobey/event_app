import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  /// Запрашивает разрешение на уведомления и возвращает, включены ли они
  Future<bool> requestNotificationPermission() async {
    var status = await Permission.notification.status;

    // Если ещё не выдано, пробуем запросить
    if (status.isDenied || status.isLimited) {
      status = await Permission.notification.request();
    }

    return status.isGranted;
  }

  /// Просто проверяет, есть ли разрешение
  Future<bool> isNotificationsEnabled() async {
    final status = await Permission.notification.status;
    return status.isGranted;
  }
}
