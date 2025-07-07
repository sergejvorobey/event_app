import 'package:event_app/core/model/result.dart';

abstract class SettingsRepositoryImpl {
  Future<Result> logOutProfile();
  Future <bool> getNotificationStatus();
}