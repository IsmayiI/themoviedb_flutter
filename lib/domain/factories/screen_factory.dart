import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb_flutter/provider/provider.dart' as old_provider;
import 'package:themoviedb_flutter/ui/widgets/auth/auth_model.dart';
import 'package:themoviedb_flutter/ui/widgets/auth/auth_widget.dart';
import 'package:themoviedb_flutter/ui/widgets/loader/loader_model.dart';
import 'package:themoviedb_flutter/ui/widgets/loader/loader_widget.dart';
import 'package:themoviedb_flutter/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:themoviedb_flutter/ui/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb_flutter/ui/widgets/movie_details/movie_details_widget.dart';
import 'package:themoviedb_flutter/ui/widgets/movie_trailer/movie_trailer_widget.dart';

class ScreenFactory {
  static Widget makeLoader() => Provider(
        lazy: false,
        create: (context) => LoaderModel(context),
        child: const LoaderWidget(),
      );

  static Widget makeAuth() => old_provider.NotifierProvider(
        create: () => AuthModel(),
        child: const AuthWidget(),
      );

  static Widget makeMainScreen() => const MainScreenWidget();

  static Widget makeMovieDetails(int movieId) => old_provider.NotifierProvider(
        create: () => MovieDetailsModel(movieId),
        child: const MovieDetailsWidget(),
      );

  static Widget makeMovieTrailer(String youTubeKey) =>
      old_provider.NotifierProvider(
        create: () => MovieDetailsModel(),
        child: MovieTrailerWidget(
          youTubeKey: youTubeKey,
        ),
      );
}
