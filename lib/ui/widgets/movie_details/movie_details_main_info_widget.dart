import 'package:flutter/material.dart';
import 'package:themoviedb_flutter/domain/api_client/api_service.dart';
import 'package:themoviedb_flutter/provider/provider.dart';
import 'package:themoviedb_flutter/ui/widgets/movie_details/circular_progress.dart';
import 'package:themoviedb_flutter/ui/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb_flutter/ui/widgets/movie_trailer/movie_trailer_widget.dart';
import 'package:themoviedb_flutter/ui/widgets/theme/app_colors.dart';
import 'package:themoviedb_flutter/utils/format_duration.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color.fromRGBO(24, 23, 27, 1),
      child: Column(
        children: [
          _PosterWidget(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: DefaultTextStyle(
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
              child: Column(
                spacing: 20,
                children: [
                  _MovieNameWidget(),
                  _ScoreWidget(),
                  _Details(),
                  _Overview(),
                  SizedBox(height: 10),
                  _Creators(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PosterWidget extends StatelessWidget {
  const _PosterWidget();

  @override
  Widget build(BuildContext context) {
    final movie =
        NotifierProvider.read<MovieDetailsModel>(context)?.movieDetails;

    if (movie == null) return const SizedBox.shrink();

    final poster = movie.posterPath == null
        ? const SizedBox.shrink()
        : Image.network(
            ApiService.imageUrl(movie.posterPath!),
            fit: BoxFit.cover,
            height: 145,
            width: 96,
          );
    final backdropImg = movie.backdropPath == null
        ? const SizedBox.shrink()
        : Image.network(
            ApiService.imageUrl(movie.backdropPath!),
            fit: BoxFit.cover,
            height: 185,
            width: double.infinity,
          );

    final backdropGradient = movie.posterPath == null
        ? const SizedBox.shrink()
        : Container(
            height: 185,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.darkBlue, AppColors.darkGrey],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          );

    final List<BoxShadow> boxShadowPoster = movie.backdropPath != null
        ? [
            const BoxShadow(
              color: AppColors.darkGrey,
              spreadRadius: 20,
              blurRadius: 100,
            ),
          ]
        : [];

    return Stack(
      children: [
        backdropGradient,
        SizedBox(
          height: 185,
          width: double.infinity,
          child: MovieTrailerWidget(youTubeKey: '9vN6DHB6bJc'),
        ),
        Positioned(
          top: 20,
          left: 20,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              boxShadow: boxShadowPoster,
            ),
            child: poster,
          ),
        ),
      ],
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget();

  @override
  Widget build(BuildContext context) {
    final movie =
        NotifierProvider.read<MovieDetailsModel>(context)?.movieDetails;

    if (movie == null) return const SizedBox.shrink();
    final title = movie.title;
    final releaseYear = movie.releaseDate?.year.toString();

    final year = releaseYear == null ? '' : ' ($releaseYear)';
    return RichText(
      textAlign: TextAlign.center,
      maxLines: 3,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          TextSpan(
            text: year,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class _Details extends StatelessWidget {
  const _Details();

  String _createTextDetails(MovieDetailsModel model) {
    final releaseDate = model.movieDetails?.releaseDate != null
        ? model.stringFromDate(model.movieDetails!.releaseDate!)
        : '';

    final country = model.movieDetails?.originCountry.first ?? '';
    final runtimeTotal = model.movieDetails?.runtime;

    final runtime = runtimeTotal != null && runtimeTotal > 0
        ? formatDuration(runtimeTotal)
        : '';

    final genres =
        model.movieDetails?.genres.map((e) => e.name).join(', ') ?? '';

    return '$releaseDate ($country), $runtime \n $genres';
  }

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<MovieDetailsModel>(context);

    if (model == null) return const SizedBox.shrink();

    final detailsText = _createTextDetails(model);

    return Text(
      detailsText,
      textAlign: TextAlign.center,
      maxLines: 3,
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview();
  @override
  Widget build(BuildContext context) {
    final movie =
        NotifierProvider.read<MovieDetailsModel>(context)?.movieDetails;

    if (movie == null) return const SizedBox.shrink();

    final overview = movie.overview;

    if (overview == null || overview.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          const Text(
            'Overview',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
          ),
          Text(overview),
        ],
      ),
    );
  }
}

class _Creators extends StatelessWidget {
  const _Creators();
  static const bigTextStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    final movie =
        NotifierProvider.read<MovieDetailsModel>(context)?.movieDetails;

    if (movie == null) return const SizedBox.shrink();

    final creatorsList = movie.credits.crew
        .where((e) => e.job == 'Director' || e.job == 'Writer')
        .toList()
        .reversed;

    final creators = creatorsList.map((e) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(e.name, style: bigTextStyle),
          Text(e.job),
        ],
      );
    }).toList();

    return SizedBox(
      width: double.infinity,
      child: Wrap(
        spacing: 60,
        runSpacing: 20,
        children: creators,
      ),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget();

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<MovieDetailsModel>(context);

    final movie = model?.movieDetails;

    if (movie == null) return const SizedBox.shrink();

    final rating = (movie.voteAverage * 10);

    final videos = movie.videos.videos;

    final trailers = videos
        .where((video) => video.type == 'Trailer' && video.site == 'YouTube')
        .toList();

    final trailerKey = trailers.isNotEmpty ? trailers.first.key : null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 6,
          children: [
            CircularProgress(percentage: rating),
            const Text(
              'User Score',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
        Container(width: 1, height: 24, color: Colors.white),
        TextButton(
          onPressed: () => trailerKey != null
              ? model?.onTapTrailer(context, trailerKey)
              : null,
          style: TextButton.styleFrom(
            disabledForegroundColor: Colors.grey,
            disabledIconColor: Colors.grey,
            foregroundColor: Colors.white,
            iconColor: Colors.white,
            iconSize: 16,
          ),
          child: const Row(
            spacing: 6,
            children: [
              Icon(Icons.play_arrow),
              Text('Play Trailer',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
