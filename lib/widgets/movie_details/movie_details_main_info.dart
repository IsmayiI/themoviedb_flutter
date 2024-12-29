import 'package:flutter/material.dart';
import 'package:themoviedb_flutter/assets/images.dart';
import 'package:themoviedb_flutter/widgets/movie_details/circular_progress.dart';

class MovieDetailsMainInfo extends StatelessWidget {
  const MovieDetailsMainInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Color.fromRGBO(24, 23, 27, 1),
      child: Column(
        children: [
          _PosterWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                  _GenreWidget(),
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
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(image: AppImages.rosemaryBackdrop),
        Positioned(
          top: 20,
          left: 20,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            width: 96,
            child: Image(image: AppImages.rosemaryImg),
          ),
        ),
      ],
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      maxLines: 3,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: 'Rosemary\'s Baby',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          TextSpan(
            text: ' (1968)',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class _GenreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'R, 06/12/1968 (US), 2h 18m \n Drama, Horror, Thriller',
      textAlign: TextAlign.center,
      maxLines: 3,
    );
  }
}

class _Overview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(
            'Overview',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
          ),
          Text(
            'A young couple, Rosemary and Guy, moves into an infamous New York apartment building, known by frightening legends and mysterious events, with the purpose of starting a family.',
          ),
        ],
      ),
    );
  }
}

class _Creators extends StatelessWidget {
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
//   const _ScoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
            spacing: 6,
            children: [
              CircularProgress(percentage: 72),
              Text(
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
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            iconColor: Colors.white,
            iconSize: 16,
          ),
          child: Row(
            spacing: 6,
            children: [
              Icon(Icons.play_arrow),
              Text('Play Trailer',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ],
    );
  }
}
