import 'package:flutter/material.dart';
import 'pages/Home.dart';

void main() {
  Widget app = const MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final String aptitle = 'Flutter Learning';

  // root
  @override
  Widget build(BuildContext context) {
    Home hp = Home(newtitle: aptitle);
    Widget matApp = MaterialApp(
      title: aptitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: hp,
    );
    return matApp;
  }
}
