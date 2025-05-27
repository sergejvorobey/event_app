import 'package:event_app/core/model/result.dart';
import 'package:event_app/features/launch/model/launch_content_response.dart';

abstract class LaunchRepositoryImpl {
  Future<Result<LaunchContentResponse>> fetchContent();
}