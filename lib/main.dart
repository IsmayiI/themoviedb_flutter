import 'package:flutter/material.dart';
import 'package:themoviedb_flutter/widgets/auth/auth_widget.dart';
import 'package:themoviedb_flutter/widgets/main_screen/main_screen_widget.dart';
import 'package:themoviedb_flutter/widgets/theme/app_colors.dart';

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
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.darkBlue,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.darkBlue,
          unselectedItemColor: AppColors.lightBlue,
          selectedItemColor: AppColors.white,
        ),
        useMaterial3: true,
      ),
      routes: {
        '/auth': (context) => AuthWidget(),
        '/main': (context) => MainScreenWidget(),
      },
      initialRoute: '/main',
    );
  }
}
