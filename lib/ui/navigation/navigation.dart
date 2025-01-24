import 'package:flutter/material.dart';
import 'package:themoviedb_flutter/domain/factories/screen_factory.dart';
import 'package:themoviedb_flutter/ui/navigation/route_names.dart';

abstract class Navigation {
  static String initialRoute() => RouteNames.loader;

  static final routes = <String, Widget Function(BuildContext)>{
    RouteNames.loader: (_) => ScreenFactory.makeLoader(),
    RouteNames.auth: (_) => ScreenFactory.makeAuth(),
    RouteNames.main: (_) => ScreenFactory.makeMainScreen(),
  };

  static Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.movieDetails:
        final movieId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => ScreenFactory.makeMovieDetails(movieId),
        );
      case RouteNames.movieDetailsTrailer:
        final youTubeKey = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ScreenFactory.makeMovieTrailer(youTubeKey),
        );
      default:
        return MaterialPageRoute(builder: (_) => const Text('404'));
    }
  }

  static void resetNavigation(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      RouteNames.loader,
      (_) => false,
    );
  }
}
