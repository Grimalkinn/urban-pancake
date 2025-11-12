// // ignore: file_names
import 'package:flutter/material.dart';

import 'package:myapp/pages/feed.dart' as feed;
import 'package:myapp/pages/profile.dart' as profile;

class Search extends StatefulWidget {
  const Search({super.key});
  @override
  State<Search> createState() { return SearchState(); }
}

class SearchState extends State<Search> {
  String query = "";
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  final List<Widget> _pages = const [
    Search(), // 0
    feed.Feed(), // 1
    profile.Profile(), // 2

  ];

  int _selectedIndex = 0;

  void _onPageTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("pin search"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Search page::',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    // body: _pages[_selectedIndex],
    // bottomNavigationBar: NavigationBar(
    //     selectedIndex: _selectedIndex,
    //     onDestinationSelected: _onPageTap,
    //     destinations: const [
    //       // NavigationDestination(icon: Icon(Icons.search_outlined), label: 'Search'),
    //       NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
    //       NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
    //     ],
    //   ),

    );
  }
}
