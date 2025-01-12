import 'package:flutter/material.dart';
import 'package:themoviedb_flutter/domain/api_client/api_service.dart';
import 'package:themoviedb_flutter/provider/provider.dart';
import 'package:themoviedb_flutter/ui/widgets/movie_details/circular_progress.dart';
import 'package:themoviedb_flutter/ui/widgets/movie_details/movie_details_model.dart';
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
        NotifierProvider.watch<MovieDetailsModel>(context).movieDetails;

    final poster = movie?.posterPath == null
        ? const SizedBox.shrink()
        : Image.network(
            ApiService.imageUrl(movie!.posterPath!),
            fit: BoxFit.cover,
            height: 145,
            width: 96,
          );
    final backdropImg = movie?.backdropPath == null
        ? const SizedBox.shrink()
        : Image.network(
            ApiService.imageUrl(movie!.backdropPath!),
            fit: BoxFit.cover,
            height: 185,
            width: double.infinity,
          );

    final backdropGradient = movie?.posterPath == null
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

    return Stack(
      children: [
        backdropGradient,
        backdropImg,
        Positioned(
          top: 20,
          left: 20,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                const BoxShadow(
                  color: AppColors.darkGrey,
                  spreadRadius: 20,
                  blurRadius: 100,
                ),
              ],
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
        NotifierProvider.watch<MovieDetailsModel>(context).movieDetails;
    final title = movie?.title ?? 'Unknown title';
    final releaseYear = movie?.releaseDate?.year.toString();

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
        NotifierProvider.watch<MovieDetailsModel>(context).movieDetails;
    final overview = movie?.overview;

    if (overview == null) return const SizedBox.shrink();

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
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 60,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Roman Polanski',
              style: bigTextStyle,
            ),
            Text(
              'Director, Screenplay',
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ira Levin',
              style: bigTextStyle,
            ),
            Text(
              'Novel',
            ),
          ],
        ),
      ],
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget();

  @override
  Widget build(BuildContext context) {
    final movie =
        NotifierProvider.watch<MovieDetailsModel>(context).movieDetails;

    final rating = (movie!.voteAverage * 10);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
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
        ),
        Container(width: 1, height: 24, color: Colors.white),
        TextButton(
          onPressed: null,
          style: TextButton.styleFrom(
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
                      color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }
}
