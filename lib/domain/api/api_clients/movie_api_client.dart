import 'package:dio/dio.dart';
import 'package:themoviedb_flutter/domain/api/api_service.dart';
import 'package:themoviedb_flutter/domain/entity/movie_details.dart';
import 'package:themoviedb_flutter/domain/entity/movie_list_response.dart';

class MovieApiClient {
  final _apiService = ApiService();

  Future<MovieListResponse> getPopularMovies({
    required String page,
    required String locale,
  }) async {
    try {
      final response =
          await _apiService.get('/movie/popular', queryParameters: {
        'page': page,
        // 'language': locale,
      });
      final data = response.data as Map<String, dynamic>;
      return MovieListResponse.fromJson(data);
    } on DioException catch (e) {
      _apiService.handleDioError(e);
      rethrow;
    }
  }

  Future<MovieListResponse> searchMovie({
    required String page,
    required String locale,
    required String query,
  }) async {
    try {
      final response = await _apiService.get('/search/movie', queryParameters: {
        'page': page,
        // 'language': locale,
        'query': query,
      });
      final data = response.data as Map<String, dynamic>;
      return MovieListResponse.fromJson(data);
    } on DioException catch (e) {
      _apiService.handleDioError(e);
      rethrow;
    }
  }

  Future<MovieDetails> getMovieDetails({
    required int id,
    required String locale,
  }) async {
    try {
      final response = await _apiService.get('/movie/$id', queryParameters: {
        'append_to_response': 'videos,credits',
        // 'language': locale,
      });
      final data = response.data as Map<String, dynamic>;
      return MovieDetails.fromJson(data);
    } on DioException catch (e) {
      _apiService.handleDioError(e);
      rethrow;
    }
  }
}
