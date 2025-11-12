import 'package:flutter/material.dart';

import '../pages/feed.dart' as feed;
import '../pages/search.dart' as search;
import '../pages/profile.dart' as profile;

import 'dart:math';

// stateful widget updates
class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => ProfileState();
} // file class

class ProfileState extends State<Profile> {
  int _counter = 0;
  final List<Widget> _pages = const [
    search.Search(),
    feed.Feed(),
    profile.Profile()
  ];
  var random = Random();
  int _selectedIndex = 2; 
  bool _isLoading = false;
  final _scrollController = ScrollController();

  void _onPageTap(int index) {
    setState(() => _selectedIndex = index);
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(title: const Text('Pin profile')),
        // body: _pages[_selectedIndex],
        // bottomNavigationBar: NavigationBar(
        //   selectedIndex: 2,
        //   onDestinationSelected: _onPageTap,
        //   destinations: const [
        //     NavigationDestination(
        //         icon: Icon(Icons.home_outlined), 
        //         label: 'Home'),
        //     NavigationDestination(
        //         icon: Icon(Icons.search_outlined), 
        //         label: 'Search'),
        //     NavigationDestination(
        //         icon: Icon(Icons.person_outline), 
        //         label: 'Profile'),
        //   ],
        // )
        // );
  // }


  @override
  Widget build(BuildContext context) {

    AppBar appbar = AppBar(
      title: const Text("pin profile"),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    );

    // TextStyle? style = Theme.of(context).textTheme.headlineMedium;
    // TextStyle fontcolor = TextStyle(color: Color.fromARGB(255, 212, 14, 120));

    Widget column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Welcome to Profile: $_counter",
          style: const TextStyle(
            color: Color.fromARGB(255, 254, 177, 201),
            fontSize: 25,
          ),
        ),
      ], // chilldren
    );

    FloatingActionButton fab = FloatingActionButton(
      onPressed: () => setState(() => _counter++),
      tooltip: 'press me',
      child: const Icon(Icons.android),
    );

    return Scaffold(
      appBar: appbar,
      body: Center(child: column),
      floatingActionButton: fab,
      backgroundColor: const Color.fromARGB(169, 0, 0, 10),
    );
  }

}

//
