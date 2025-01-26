import 'package:dio/dio.dart';
import 'package:themoviedb_flutter/domain/api/api_service.dart';

class AuthApiClient {
  final _apiService = ApiService();

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
      final response = await _apiService.get('/authentication/token/new');
      final data = response.data as Map<String, dynamic>;
      return data['request_token'];
    } on DioException catch (e) {
      _apiService.handleDioError(e);
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

      final response = await _apiService.post(
        '/authentication/token/validate_with_login',
        data: body,
      );
      final data = response.data as Map<String, dynamic>;
      return data['request_token'];
    } on DioException catch (e) {
      _apiService.handleDioError(e);
      rethrow;
    }
  }

  Future<String> _makeSession(String token) async {
    try {
      final body = {'request_token': token};

      final response = await _apiService.post(
        '/authentication/session/new',
        data: body,
      );
      final data = response.data as Map<String, dynamic>;
      return data['session_id'];
    } on DioException catch (e) {
      _apiService.handleDioError(e);
      rethrow;
    }
  }
}
