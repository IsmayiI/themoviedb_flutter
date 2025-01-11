import 'package:flutter/material.dart';
import 'package:themoviedb_flutter/provider/provider.dart';
import 'package:themoviedb_flutter/ui/navigation/route_names.dart';
import 'package:themoviedb_flutter/ui/widgets/auth/auth_model.dart';
import 'package:themoviedb_flutter/ui/widgets/auth/auth_widget.dart';
import 'package:themoviedb_flutter/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:themoviedb_flutter/ui/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb_flutter/ui/widgets/movie_details/movie_details_widget.dart';

abstract class Navigation {
  static String initialRoute(isAuth) =>
      isAuth ? RouteNames.main : RouteNames.auth;

  static final routes = <String, Widget Function(BuildContext)>{
    RouteNames.auth: (_) =>
        NotifierProvider(create: () => AuthModel(), child: const AuthWidget()),
    RouteNames.main: (_) => const MainScreenWidget(),
  };

  static Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.movieDetails:
        final movieId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => NotifierProvider(
              create: () => MovieDetailsModel(movieId),
              child: const MovieDetailsWidget()),
        );

      default:
        return MaterialPageRoute(builder: (_) => const Text('404'));
    }
  }
}
