// // ignore: file_names
import 'package:flutter/material.dart';
import 'package:myapp/pages/profile.dart';

import '../subpages/lookup.dart' as lookup;

class Search extends StatefulWidget {
  static List<String> history = ["banana", "pear", "dog", "cat"];
  const Search({super.key});
  @override
  State<Search> createState() {
    return SearchState();
  }
}

class SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromRGBO(44, 45, 49, 1),
      backgroundColor: const Color.fromARGB(255, 220, 208, 41),
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: const Color.fromARGB(255, 220, 208, 41),
        backgroundColor: const Color.fromARGB(255, 93, 93, 94),
        title: const Text("Search..."),
        // title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
            children: <Widget> [
              Row(
                children: [
                  // Text(Search.history),
                  // Image(image: NetworkImage("https://frostingandfettuccine.com/wp-content/uploads/2022/11/Marble-cupcakes-13.jpg")),
                  Image(image: AssetImage("assets/chocolate-cupcakes.jpg")),
                  Image(image: AssetImage("assets/marble-cupcakes.jpg")),
                ]
              ),
              // Image(image: NetworkImage("https://frostingandfettuccine.com/wp-content/uploads/2022/11/Marble-cupcakes-13.jpg")),
              Image(image: AssetImage("assets/chocolate-cupcakes.jpg")),
              Image(image: AssetImage("assets/marble-cupcakes.jpg")),
              
            ],
            // mainAxisAlignment: MainAxisAlignment.center,
        
          
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.search),
        // onPressed: () => query = "",
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
              lookup.Lookup(searched: query),
            ),
        ),
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
    for (var fruit in Search.history) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
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
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in Search.history) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
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
