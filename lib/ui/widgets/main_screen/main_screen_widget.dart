import 'package:flutter/material.dart';
import 'package:themoviedb_flutter/domain/factories/screen_factory.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 1;

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Image(
          image: AssetImage('images/tmdb.png'),
          width: 55,
        ),
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          const Text(
            'Home',
          ),
          ScreenFactory.makeMovieList(),
          const Text(
            'Tv Shows',
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.theaters),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            label: 'Tv Shows',
          ),
        ],
        onTap: onSelectTab,
      ),
    );
  }
}
