import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  const ApiException(this.message);

  @override
  String toString() => message;
}

class ApiClient {
  final Dio _dio = Dio();

  static const _host = 'https://api.themoviedb.org/3';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = '22d60abf9343e50aa2c5da10d9cf03b1';

  Future<String> auth({
    required String username,
    required String password,
  }) async {
    try {
      final token = await _makeToken();
      final validatedToken = await _validateToken(username, password, token);
      final sessionId = await _makeSession(validatedToken);
      return sessionId;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> _makeToken() async {
    try {
      final response =
          await _dio.get('$_host/authentication/token/new?api_key=$_apiKey');
      final data = response.data as Map<String, dynamic>;
      return data['request_token'];
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  Future<String> _validateToken(
    String username,
    String password,
    String token,
  ) async {
    try {
      final body = {
        'username': username,
        'password': password,
        'request_token': token,
      };

      final response = await _dio.post(
        '$_host/authentication/token/validate_with_login?api_key=$_apiKey',
        data: body,
      );
      final data = response.data as Map<String, dynamic>;
      return data['request_token'];
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  Future<String> _makeSession(String token) async {
    try {
      final body = {'request_token': token};

      final response = await _dio.post(
        '$_host/authentication/session/new?api_key=$_apiKey',
        data: body,
      );
      final data = response.data as Map<String, dynamic>;
      return data['session_id'];
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  void _handleDioError(DioException e) {
    if (e.response != null) {
      throw ApiException(
          e.response?.data['status_message'] ?? 'Unknown error occurred');
    } else if (e.type == DioExceptionType.connectionError) {
      throw ApiException('No internet connection. Please try again later.');
    } else {
      throw ApiException('An unexpected error occurred.');
    }
  }
}
