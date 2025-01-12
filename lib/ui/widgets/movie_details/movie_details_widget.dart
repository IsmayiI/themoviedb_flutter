import 'package:flutter/material.dart';
import 'package:themoviedb_flutter/provider/provider.dart';
import 'package:themoviedb_flutter/ui/widgets/movie_details/movie_details_cast_info_widget.dart';
import 'package:themoviedb_flutter/ui/widgets/movie_details/movie_details_main_info_widget.dart';
import 'package:themoviedb_flutter/ui/widgets/movie_details/movie_details_model.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({super.key});

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    NotifierProvider.read<MovieDetailsModel>(context)?.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB'),
      ),
      backgroundColor: Colors.white,
      body: const _BodyWidget(),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget();

  @override
  Widget build(BuildContext context) {
    final movie =
        NotifierProvider.watch<MovieDetailsModel>(context).movieDetails;

    if (movie == null) {
      return ColoredBox(
          color: Color.fromRGBO(24, 23, 27, 1),
          child: Center(
              child: const CircularProgressIndicator(
            color: Colors.white,
          )));
    }

    return ListView(
      children: [
        const MovieDetailsMainInfoWidget(),
        const MovieDetailsCastInfoWidget(),
      ],
    );
  }
}
