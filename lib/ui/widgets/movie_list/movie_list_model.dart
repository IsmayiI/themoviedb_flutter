import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb_flutter/domain/api_client/api_client.dart';
import 'package:themoviedb_flutter/domain/entity/movie.dart';
import 'package:themoviedb_flutter/ui/navigation/route_names.dart';

class MovieListModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _movies = <Movie>[];
  List<Movie> get movies => List.unmodifiable(_movies);
  late DateFormat _dateFormat;
  String _locale = '';

  void setupLocale(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    _movies.clear();
    _loadPopularMovies();
  }

  String stringFromDate(DateTime date) => _dateFormat.format(date);

  Future<void> _loadPopularMovies() async {
    final response = await _apiClient.getPopularMovies(locale: _locale);
    _movies.addAll(response.movies);
    notifyListeners();
  }

  void onTapMovie(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(RouteNames.movieDetails, arguments: id);
  }
}
