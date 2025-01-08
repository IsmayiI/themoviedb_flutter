import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();

  static const _host = 'https://api.themoviedb.org/3';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = '22d60abf9343e50aa2c5da10d9cf03b1';

  Future<String> auth({
    required String username,
    required String password,
  }) async {
    final token = await _makeToken();
    final validatedToken = await _validateToken(username, password, token);
    final sessionId = await _makeSession(validatedToken);
    return sessionId;
  }

  Future<String> _makeToken() async {
    final response =
        await _dio.get('$_host/authentication/token/new?api_key=$_apiKey');
    final data = response.data as Map<String, dynamic>;
    return data['request_token'];
  }

  Future<String> _validateToken(
    String username,
    String password,
    String token,
  ) async {
    final body = <String, dynamic>{
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
  }

  Future<String> _makeSession(String token) async {
    final body = <String, dynamic>{
      'request_token': token,
    };

    final response = await _dio.post(
      '$_host/authentication/session/new?api_key=$_apiKey',
      data: body,
    );
    final data = response.data as Map<String, dynamic>;
    return data['session_id'];
  }
}
