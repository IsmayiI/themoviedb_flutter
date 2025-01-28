import 'package:themoviedb_flutter/domain/api/api_clients/movie_api_client.dart';
import 'package:themoviedb_flutter/domain/entity/movie_list_response.dart';

class MovieListService {
  final _apiClient = MovieApiClient();

  Future<MovieListResponse> getPopularMovies({
    required int page,
    required String locale,
  }) async =>
      _apiClient.getPopularMovies(
        page: page.toString(),
        locale: locale,
      );

  Future<MovieListResponse> searchMovie({
    required int page,
    required String locale,
    required String query,
  }) async =>
      _apiClient.searchMovie(
        page: page.toString(),
        locale: locale,
        query: query,
      );
}
