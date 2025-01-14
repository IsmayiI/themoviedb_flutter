import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb_flutter/domain/api_client/api_client.dart';
import 'package:themoviedb_flutter/domain/api_client/api_exeption.dart';
import 'package:themoviedb_flutter/domain/entity/movie.dart';
import 'package:themoviedb_flutter/domain/entity/movie_list_response.dart';
import 'package:themoviedb_flutter/ui/navigation/route_names.dart';

class MovieListModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _movies = <Movie>[];
  var _isLoadProgress = false;
  late int _currentPage;
  late int _totalPage;
  late DateFormat _dateFormat;
  String _locale = '';
  String? _searchQuery;
  Timer? _searchDebounce;
  String? _errorMessage;
  List<Movie> get movies => List.unmodifiable(_movies);
  String? get errorMessage => _errorMessage;

  String stringFromDate(DateTime date) => _dateFormat.format(date);

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await _reloadMovies();
  }

  Future<void> _reloadMovies() async {
    _currentPage = 0;
    _totalPage = 1;
    _movies.clear();
    await _loadNextPageMovies();
  }

  Future<MovieListResponse> _loadMovies(String locale, int nextPage) async {
    try {
      if (_searchQuery != null) {
        return await _apiClient.searchMovie(
            locale: locale, page: nextPage, query: _searchQuery!);
      }
      return await _apiClient.getPopularMovies(
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
      _movies.addAll(response.movies);

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
    notifyListeners();
  }

  Future<void> searchMovie(String text) async {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 300), () async {
      final searchQuery = text.trim().isEmpty ? null : text;
      if (searchQuery == _searchQuery) return;
      _searchQuery = searchQuery;
      await _reloadMovies();
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
}
