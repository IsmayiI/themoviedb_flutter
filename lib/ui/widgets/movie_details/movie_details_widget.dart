import 'package:flutter/material.dart';
import 'package:themoviedb_flutter/provider/provider.dart';
import 'package:themoviedb_flutter/ui/widgets/movie_details/movie_details_cast_info_widget.dart';
import 'package:themoviedb_flutter/ui/widgets/movie_details/movie_details_main_info.dart';
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
        title: const TitleWidget(),
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

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final title =
        NotifierProvider.watch<MovieDetailsModel>(context).movieDetails?.title;

    if (title == null) {
      return const CircularProgressIndicator(
        color: Colors.white,
      );
    }

    return Text(title);
  }
}
