import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  static const _host = 'https://api.themoviedb.org/3';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = '22d60abf9343e50aa2c5da10d9cf03b1';

  static String imageUrl(String path) => '$_imageUrl$path';

  ApiService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: _host,
            queryParameters: {'api_key': _apiKey},
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
