import 'package:event_app/core/model/result.dart';
import 'package:event_app/core/notification/notification_service.dart';
import 'package:event_app/core/storage/storage_service.dart';
import 'package:event_app/features/menu/settings/repository/settings_repository_impl.dart';
import 'package:get_it/get_it.dart';

class SettingsRepository extends SettingsRepositoryImpl {
  final StorageService _storageService;

  SettingsRepository({required StorageService storageService})
    : _storageService = storageService;

  @override
  Future<Result> logOutProfile() async {
    await _storageService.clearTokens();
    final accessToken = await _storageService.getAccessToken();
    return accessToken == null || accessToken.isEmpty
        ? const Success("")
        : Failure(Exception("Ошибка, что-то пошло не так"));
  }

  @override
  Future<bool> getNotificationStatus() async {
    final notificationService = GetIt.I<NotificationService>();
    return await notificationService.isNotificationsEnabled();
  }
}
