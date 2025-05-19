import 'dart:convert';

import 'package:event_app/core/enum/http_method.dart';
import 'package:event_app/core/model/http_exception.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  final String _baseUrl = 'http://194.87.236.187:8080/';
  final http.Client _client;

  NetworkService({http.Client? client}) : _client = client ?? http.Client();

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

      final requestHeaders = {'Content-Type': 'application/json', ...?headers};

      http.Response response;

      switch (method) {
        case HttpMethod.post:
          response = await _client.post(
            uri,
            headers: requestHeaders,
            body: body != null ? jsonEncode(body) : null,
          );
          break;
        case HttpMethod.put:
          response = await _client.put(
            uri,
            headers: requestHeaders,
            body: body != null ? jsonEncode(body) : null,
          );
          break;
        case HttpMethod.patch:
          response = await _client.patch(
            uri,
            headers: requestHeaders,
            body: body != null ? jsonEncode(body) : null,
          );
          break;
        case HttpMethod.delete:
          response = await _client.delete(
            uri,
            headers: requestHeaders,
            body: body != null ? jsonEncode(body) : null,
          );
          break;
        case HttpMethod.head:
          response = await _client.head(uri, headers: requestHeaders);
          break;
        case HttpMethod.get:
          if (body != null) {
            response = await _sendGetWithBody(
              uri,
              headers: requestHeaders,
              body: body,
            );
          } else {
            response = await _client.get(uri, headers: requestHeaders);
          }
          break;
      }

      return _handleResponse(response);
    } catch (exception) {
      debugPrint(exception.toString());

      if (exception is HttpException) {
        rethrow;
      } else {
        throw HttpException(message: exception.toString());
      }
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

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body.isNotEmpty ? jsonDecode(response.body) : null;
    } else {
      String errorMessage = 'Неизвестная ошибка';
      try {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic> && decoded['message'] != null) {
          errorMessage = decoded['message'];
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

  void dispose() {
    _client.close();
  }
}
