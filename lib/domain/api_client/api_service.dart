import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  static const String _apiKey = '22d60abf9343e50aa2c5da10d9cf03b1';

  ApiService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'https://api.themoviedb.org/3', // Базовый URL
            queryParameters: {'api_key': _apiKey}, // Встроенный API-ключ
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

  // Метод для добавления или изменения заголовков
  void setHeaders(Map<String, String> headers) {
    _dio.options.headers.addAll(headers);
  }
}
