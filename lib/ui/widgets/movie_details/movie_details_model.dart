import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb_flutter/domain/api_client/api_client.dart';
import 'package:themoviedb_flutter/domain/api_client/api_exeption.dart';
import 'package:themoviedb_flutter/domain/entity/movie_details.dart';
import 'package:themoviedb_flutter/ui/navigation/route_names.dart';

class MovieDetailsModel extends ChangeNotifier {
  final apiClient = ApiClient();
  MovieDetails? _movieDetails;
  String _locale = '';
  late DateFormat _dateFormat;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  MovieDetails? get movieDetails => _movieDetails;

  final int? movieId;
  MovieDetailsModel([this.movieId]);

  String stringFromDate(DateTime date) => _dateFormat.format(date);

  void onTapTrailer(BuildContext context, String key) {
    Navigator.pushNamed(context, RouteNames.movieDetailsTrailer,
        arguments: key);
  }

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await _loadMovieDetails();
  }

  Future<void> _loadMovieDetails() async {
    try {
      _movieDetails =
          await apiClient.getMovieDetails(id: movieId!, locale: _locale);
    } catch (e) {
      if (e is ApiException) {
        _errorMessage = e.message;
      } else {
        _errorMessage = 'Unknown error occurred';
      }
    }
    notifyListeners();
  }
}
