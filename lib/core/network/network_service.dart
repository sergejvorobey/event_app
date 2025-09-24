import 'dart:convert';
import 'package:event_app/core/enum/http_method.dart';
import 'package:event_app/core/model/http_exception.dart';
import 'package:event_app/core/storage/storage_service.dart';
import 'package:event_app/features/auth/registration/V1/repository/model/token_response.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:talker_flutter/talker_flutter.dart';

class NetworkService {
  final String _baseUrl = 'http://194.87.236.187:8080/';
  final http.Client _client;

  NetworkService({http.Client? client}) : _client = client ?? http.Client();

  final StorageService _storageService = StorageService();

  Future<dynamic> request({
    required String path,
    HttpMethod method = HttpMethod.get,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse(
        '$_baseUrl$path',
      ).replace(queryParameters: queryParameters);

      final accessToken = await _storageService.getAccessToken();
      final requestHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        ...?headers,
      };

      http.Response response = await _sendHttpRequest(
        uri,
        method,
        requestHeaders,
        body,
      );

      try {
        return _handleResponse(response);
      } on HttpException catch (e) {
        // Если 401 — пробуем обновить токен и повторить запрос
        if (e.statusCode == 401) {
          await refreshToken();

          final newToken = await _storageService.getAccessToken();
          // Обновляем заголовки
          requestHeaders['Authorization'] = 'Bearer $newToken';

          final retryResponse = await _sendHttpRequest(
            uri,
            method,
            requestHeaders,
            body,
          );

          return await _handleResponse(retryResponse);
        } else {
          rethrow;
        }
      }
    } catch (exception, st) {
      GetIt.I<Talker>().handle(exception, st);
      throw HttpException(message: exception.toString());
    }
  }

  Future<http.Response> _sendGetWithBody(
    Uri uri, {
    required Map<String, String> headers,
    required Map<String, dynamic> body,
  }) async {
    final request =
        http.Request('GET', uri)
          ..headers.addAll(headers)
          ..body = jsonEncode(body);

    final streamedResponse = await _client.send(request);
    return await http.Response.fromStream(streamedResponse);
  }

  Future<http.Response> _sendHttpRequest(
    Uri uri,
    HttpMethod method,
    Map<String, String> headers,
    Map<String, dynamic>? body,
  ) async {
    switch (method) {
      case HttpMethod.post:
        return _client.post(
          uri,
          headers: headers,
          body: body != null ? jsonEncode(body) : null,
        );
      case HttpMethod.put:
        return _client.put(
          uri,
          headers: headers,
          body: body != null ? jsonEncode(body) : null,
        );
      case HttpMethod.patch:
        return _client.patch(
          uri,
          headers: headers,
          body: body != null ? jsonEncode(body) : null,
        );
      case HttpMethod.delete:
        return _client.delete(
          uri,
          headers: headers,
          body: body != null ? jsonEncode(body) : null,
        );
      case HttpMethod.head:
        return _client.head(uri, headers: headers);
      case HttpMethod.get:
        if (body != null) {
          return _sendGetWithBody(uri, headers: headers, body: body);
        } else {
          return _client.get(uri, headers: headers);
        }
    }
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      GetIt.I<Talker>().log(jsonDecode(response.body));
      return response.body.isNotEmpty ? jsonDecode(response.body) : null;
    } else {
      String errorMessage = 'Неизвестная ошибка';
      try {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic> && decoded['message'] != null) {
          errorMessage = decoded['message'];
          GetIt.I<Talker>().handle(response.statusCode, null, errorMessage);
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
    try {
      final response = await request(
        path: "token/refresh",
        method: HttpMethod.post,
        body: {"refreshToken": await _storageService.getRefreshToken()},
      );
      final tokenResponse = TokenResponse.fromJson(
        response as Map<String, dynamic>,
      );
      await _storageService.saveTokens(
        accessToken: tokenResponse.accessToken,
        refreshToken: tokenResponse.refreshToken,
      );
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st, 'REFRESH TOKEN ERROR');
    }
  }

  void dispose() {
    _client.close();
  }
}
