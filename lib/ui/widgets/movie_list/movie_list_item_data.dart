class MovieListItemData {
  final int id;
  final String title;
  final String overview;
  final String releaseDate;
  final String? posterPath;

  const MovieListItemData({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.posterPath,
  });
}
