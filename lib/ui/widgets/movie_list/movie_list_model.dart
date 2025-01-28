import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb_flutter/domain/api/api_exeption.dart';
import 'package:themoviedb_flutter/domain/entity/movie.dart';
import 'package:themoviedb_flutter/domain/entity/movie_list_response.dart';
import 'package:themoviedb_flutter/domain/services/movie_list_service.dart';
import 'package:themoviedb_flutter/ui/navigation/route_names.dart';
import 'package:themoviedb_flutter/ui/widgets/movie_list/movie_list_item_data.dart';

class MovieListModel extends ChangeNotifier {
  final _movieListService = MovieListService();
  final _movies = <MovieListItemData>[];
  var _isLoadProgress = false;
  var _listLoading = false;
  late int _currentPage;
  late int _totalPage;
  late DateFormat _dateFormat;
  String _locale = '';
  String? _searchQuery;
  Timer? _searchDebounce;
  String? _errorMessage;
  List<MovieListItemData> get movies => List.unmodifiable(_movies);
  String? get errorMessage => _errorMessage;
  bool get isListLoading => _listLoading;

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    // _dateFormat = DateFormat.yMMMMd(locale);
    _dateFormat = DateFormat.yMMMMd('en_US');
    _reloadMovies();
    await _loadNextPageMovies();
  }

  void _reloadMovies() {
    _currentPage = 0;
    _totalPage = 1;
    _movies.clear();
    _listLoading = true;
  }

  Future<MovieListResponse> _loadMovies(String locale, int nextPage) async {
    try {
      if (_searchQuery != null) {
        return await _movieListService.searchMovie(
            locale: locale, page: nextPage, query: _searchQuery!);
      }
      return await _movieListService.getPopularMovies(
        locale: locale,
        page: nextPage,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _loadNextPageMovies() async {
    if (_isLoadProgress || _currentPage >= _totalPage) return;
    _isLoadProgress = true;
    final nextPage = _currentPage + 1;

    try {
      final response = await _loadMovies(_locale, nextPage);
      _movies.addAll(response.movies.map(_makeMovieListItemData).toList());

      _currentPage = response.page;
      _totalPage = response.totalPages;
      _isLoadProgress = false;
    } catch (e) {
      _isLoadProgress = false;
      if (e is ApiException) {
        _errorMessage = e.message;
      } else {
        _errorMessage = 'Unknown error occurred';
      }
    }
    _listLoading = false;
    notifyListeners();
  }

  Future<void> searchMovie(String text) async {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 300), () async {
      final searchQuery = text.trim().isEmpty ? null : text.trim();
      if (searchQuery == _searchQuery) return;
      _searchQuery = searchQuery;
      _reloadMovies();
      notifyListeners();
      await _loadNextPageMovies();
    });
  }

  void onScrollEnd(int index) {
    if (index < _movies.length - 1) return;
    _loadNextPageMovies();
  }

  void onTapMovie(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(RouteNames.movieDetails, arguments: id);
  }

  MovieListItemData _makeMovieListItemData(Movie movie) {
    final releaseDate = movie.releaseDate;
    final releaseDateStr =
        releaseDate == null ? '' : _dateFormat.format(releaseDate);

    return MovieListItemData(
      id: movie.id,
      title: movie.title,
      posterPath: movie.posterPath,
      overview: movie.overview,
      releaseDate: releaseDateStr,
    );
  }
}
