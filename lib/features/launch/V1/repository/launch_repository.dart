import 'package:event_app/core/enum/http_method.dart';
import 'package:event_app/core/model/result.dart';
import 'package:event_app/core/network/network_sevice_v2.dart';
import 'package:event_app/features/launch/V1/model/launch_content_response.dart';
import 'package:event_app/features/launch/V1/repository/launch_repository_impl.dart';

class LaunchRepository extends LaunchRepositoryImpl {
  final NetworkServiceV2 _networkService;

  LaunchRepository({required NetworkServiceV2 networkService})
    : _networkService = networkService;

  @override
  Future<Result<LaunchContentResponse>> fetchContent() async {
    try {
      final response = await _networkService.request(
        path: "auth/connect",
        method: HttpMethod.post,
      );

      final authResponse = LaunchContentResponse.fromJson(
        response as Map<String, dynamic>,
      );
      return Success(authResponse);
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }
}
