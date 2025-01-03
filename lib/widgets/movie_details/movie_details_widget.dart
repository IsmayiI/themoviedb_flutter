import 'package:flutter/material.dart';
import 'package:themoviedb_flutter/widgets/movie_details/movie_details_cast_info_widget.dart';
import 'package:themoviedb_flutter/widgets/movie_details/movie_details_main_info.dart';

class MovieDetailsWidget extends StatefulWidget {
  final int movieId;
  const MovieDetailsWidget({super.key, required this.movieId});

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB'),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          MovieDetailsMainInfo(),
          MovieDetailsCastInfoWidget(),
        ],
      ),
    );
  }
}
