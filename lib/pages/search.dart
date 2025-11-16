// // ignore: file_names
import 'package:flutter/material.dart';

import 'package:myapp/pages/feed.dart' as feed;
import 'package:myapp/pages/profile.dart' as profile;

class Search extends StatefulWidget {
  const Search({super.key});
  @override
  State<Search> createState() {
    return SearchState();
  }
}

class SearchState extends State<Search> {
  String query = "";
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // final List<Widget> _pages = const [
  //   Search(), // 0
  //   feed.Feed(), // 1
  //   profile.Profile(), // 2

  // ];

  int _selectedIndex = 0;

  void _onPageTap(int index) {
    setState(() => _selectedIndex = index);
  }

  void show({context, delegate}) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(44, 45, 49, 1),
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // title: const Text("pin search"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              show(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          )
        ],
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

class CustomSearchDelegate extends SearchDelegate {
  List<String> history = ["banana", "pear", "dog", "cat"];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = "...",
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      // leave and close search bar
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in history) {
      if (fruit.toLowerCase().contains(query.toLowerCase())){ 
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in history) {
      if (fruit.toLowerCase().contains(query.toLowerCase())){ 
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      }
    );
  }
}
