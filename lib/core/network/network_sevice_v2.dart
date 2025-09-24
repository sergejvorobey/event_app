import 'package:event_app/core/enum/http_method.dart';
import 'package:event_app/core/model/http_exception.dart';
import 'package:event_app/core/network/dio_config.dart';
import 'package:event_app/core/storage/storage_service.dart';
import 'package:event_app/features/auth/registration/V1/repository/model/token_response.dart';
import 'package:dio/dio.dart';

class NetworkServiceV2 {
  final StorageService _storageService = StorageService();
  late final Dio _dio;

  NetworkServiceV2({Dio? dio}) {
    _dio = dio ?? DioConfig.createDio();
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          final isRefreshing = error.requestOptions.extra['__isRetry'] == true;

          if (error.response?.statusCode == 401 && !isRefreshing) {
            try {
              await refreshToken();
              final accessToken = await _storageService.getAccessToken();

              final newRequestOptions = error.requestOptions.copyWith(
                headers: {
                  ...error.requestOptions.headers,
                  'Authorization': 'Bearer $accessToken',
                },
                extra: {...error.requestOptions.extra, '__isRetry': true},
              );

              final response = await _dio.fetch(newRequestOptions);
              return handler.resolve(response);
            } catch (e) {
              return handler.reject(error);
            }
          }

          return handler.next(error);
        },
      ),
    );
  }

  Future<dynamic> request({
    required String path,
    HttpMethod method = HttpMethod.get,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final accessToken = await _storageService.getAccessToken();
      final requestHeaders = {
        'Content-Type': 'application/json',
        if (accessToken != null) 'Authorization': 'Bearer $accessToken',
        ...?headers,
      };

      final options = Options(
        method: method.name.toUpperCase(),
        headers: requestHeaders,
      );

      final response = await _dio.request(
        path,
        options: options,
        queryParameters: queryParameters,
        data: body,
      );

      return _handleResponse(response);
    } catch (exception) {
      if (exception is DioException) {
        throw HttpException(
          statusCode: exception.response?.statusCode,
          message: exception.response?.data?['message'] ?? exception.message,
        );
      }
      throw HttpException(message: exception.toString());
    }
  }

  dynamic _handleResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return response.data;
    } else {
      String errorMessage = 'Неизвестная ошибка';
      try {
        if (response.data is Map<String, dynamic> &&
            response.data['message'] != null) {
          errorMessage = response.data['message'];
        }
      } catch (_) {
        // ignore
      }

      throw HttpException(
        statusCode: response.statusCode,
        message: errorMessage,
      );
    }
  }

  Future refreshToken() async {
    final refreshToken = await _storageService.getRefreshToken();

    if (refreshToken == null) {
      throw HttpException(message: "Refresh token is empty");
    }

    try {
      final response = await _dio.post(
        'auth/refresh',
        data: {'refreshToken': refreshToken},
        options: Options(
          headers: {'Content-Type': 'application/json'},
          extra: {'__isRetry': true},
        ),
      );

      final tokenResponse = TokenResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      await _storageService.saveTokens(
        accessToken: tokenResponse.accessToken,
        refreshToken: tokenResponse.refreshToken,
      );
    } catch (_) {
      throw HttpException(message: "Token refresh failed");
    }
  }

  void dispose() {
    _dio.close();
  }
}
