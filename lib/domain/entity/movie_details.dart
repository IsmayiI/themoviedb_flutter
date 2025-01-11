import 'package:json_annotation/json_annotation.dart';
import 'package:themoviedb_flutter/utils/parse_string_to_datetime.dart';

part 'movie_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetails {
  MovieDetails({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
  final bool adult;
  final String? backdropPath;
  final dynamic belongsToCollection;
  final int budget;
  final List<Genres> genres;
  final String? homepage;
  final int id;
  final String? imdbId;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalTitle;
  final String? overview;
  final double popularity;
  final String? posterPath;
  final List<dynamic> productionCompanies;
  final List<dynamic> productionCountries;
  @JsonKey(fromJson: parseStringToDateTime)
  final DateTime? releaseDate;
  final int revenue;
  final int? runtime;
  final List<dynamic> spokenLanguages;
  final String status;
  final String? tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  factory MovieDetails.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsToJson(this);
}

@JsonSerializable()
class Genres {
  Genres({
    required this.id,
    required this.name,
  });
  final int id;
  final String name;

  factory Genres.fromJson(Map<String, dynamic> json) => _$GenresFromJson(json);

  Map<String, dynamic> toJson() => _$GenresToJson(this);
}
