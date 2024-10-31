import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  // stateful widget updates
  final String title = "Home";

  // constructor
  Home(String newtitle, {super.key}) {
    final title = newtitle;
  }

  @override
  State<Home> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  int _counter = 0;

  // constructor
  HomeState();

  @override
  Widget build(BuildContext context) {
    Text title = Text(widget.title);
    AppBar appbar = AppBar(
      title: title,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    );

    TextStyle? style = Theme.of(context).textTheme.headlineMedium;

    Widget column = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
            Text(
                "Welcome home: $_counter",
                style: style,
                selectionColor: Color.fromARGB(255, 10, 239, 170),
            )
        ],
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