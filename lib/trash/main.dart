import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'dart:math';

import '../pages/feed.dart' as feed;
import '../pages/search.dart' as search;
import '../pages/profile.dart' as profile;
// import '../services/image_service.dart';

void main() {
  return runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      home: const App(),
      theme: ThemeData(
        useMaterial3: true,
        // colorSchemeSeed: Colors.redAccent
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});
  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  var random = Random();
  int _selectedIndex = 0; // feed page as start page

  final List<Widget> _pages = const [
    search.Search(), // 0
    feed.Feed(), // 1
    profile.Profile(), //2
  ];
  // bool _isLoading = false;
  // final _scrollController = ScrollController();

  void _onPageTap(int index) {
    setState(() => _selectedIndex = index);
  }


  void setIndex({int ind = 1}) => setState(() => _selectedIndex = ind);
  


  @override
  Widget build(BuildContext context) {
    setIndex(ind: 0);

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color.fromRGBO(65, 66, 72, 1),
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onPageTap,
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.search_outlined), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Feed'),
          NavigationDestination(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
