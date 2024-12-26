import 'package:flutter/material.dart';
import 'package:themoviedb_flutter/widgets/auth/auth_widget.dart';
import 'package:themoviedb_flutter/widgets/main_screen/main_screen_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
          backgroundColor: const Color.fromRGBO(3, 37, 65, 1),
        ),
        useMaterial3: true,
      ),
      routes: {
        '/auth': (context) => AuthWidget(),
        '/main': (context) => MainScreenWidget(),
      },
      initialRoute: '/auth',
    );
  }
}
