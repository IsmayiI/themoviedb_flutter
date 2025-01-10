import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb_flutter/domain/api_client/api_client.dart';
import 'package:themoviedb_flutter/domain/api_client/api_exeption.dart';
import 'package:themoviedb_flutter/domain/entity/movie.dart';
import 'package:themoviedb_flutter/ui/navigation/route_names.dart';

class MovieListModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _movies = <Movie>[];
  late int _currentPage;
  late int _totalPage;
  var _isLoadProgress = false;
  List<Movie> get movies => List.unmodifiable(_movies);
  late DateFormat _dateFormat;
  String _locale = '';
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void setupLocale(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    _currentPage = 0;
    _totalPage = 1;
    _movies.clear();
    _loadPopularMovies();
  }

  String stringFromDate(DateTime date) => _dateFormat.format(date);

  Future<void> _loadPopularMovies() async {
    if (_isLoadProgress || _currentPage >= _totalPage) return;
    _isLoadProgress = true;
    final nextPage = _currentPage + 1;

    try {
      final response = await _apiClient.getPopularMovies(
        locale: _locale,
        page: nextPage,
      );
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

  void onScrollEnd(int index) {
    if (index < _movies.length - 1) return;
    _loadPopularMovies();
  }

  void onTapMovie(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(RouteNames.movieDetails, arguments: id);
  }
}
