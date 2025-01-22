import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:themoviedb_flutter/ui/navigation/navigation.dart';
import 'package:themoviedb_flutter/ui/widgets/theme/app_colors.dart';

void main() {
  final app = MyApp();
  runApp(app);
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', 'RU'),
        Locale('en', 'US'),
      ],
      routes: Navigation.routes,
      onGenerateRoute: Navigation.onGenerateRoute,
      initialRoute: Navigation.initialRoute(),
    );
  }
}
