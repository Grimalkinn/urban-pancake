import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  // stateful widget updates

  // constructor
  const Profile({super.key});

  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  int _counter = 0;

  // constructor
  ProfileState();

  @override
  Widget build(BuildContext context) {
    Text title = const Text("profile");
    AppBar appbar = AppBar(
      title: title,
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