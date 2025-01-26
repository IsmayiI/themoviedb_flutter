import 'package:dio/dio.dart';
import 'package:themoviedb_flutter/domain/api/api_config.dart';
import 'package:themoviedb_flutter/domain/api/api_exeption.dart';

class ApiService {
  final Dio _dio;

  ApiService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: ApiConfig.host,
            queryParameters: {'api_key': ApiConfig.apiKey},
          ),
        );

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    // Объединяем параметры запроса с встроенным API-ключом
    final combinedParams = {...?queryParameters};
    return _dio.get(
      path,
      queryParameters: combinedParams,
      options: options,
    );
  }

  Future<Response> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Options? options,
  }) async {
    final combinedParams = {...?queryParameters};
    return _dio.post(
      path,
      queryParameters: combinedParams,
      data: data,
      options: options,
    );
  }

  void handleDioError(DioException e) {
    if (e.response != null) {
      throw ApiException(
          e.response?.data['status_message'] ?? 'Unknown error occurred');
    } else if (e.type == DioExceptionType.connectionError) {
      throw ApiException('No internet connection. Please try again later.');
    } else {
      throw ApiException('An unexpected error occurred.');
    }
  }

  // Метод для добавления или изменения заголовков
  void setHeaders(Map<String, String> headers) {
    _dio.options.headers.addAll(headers);
  }
}
