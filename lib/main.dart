import 'package:flutter/material.dart';

import 'pages/home.dart';

void main() {
  Widget app = const App();
  runApp(app);
}

class App extends StatelessWidget {
  // stateless widget are static
  final String title = "App";

  // constructor
  const App({super.key});

  // root
  @override
  Widget build(BuildContext context) {
    Home home = Home(title);

    ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 212, 14, 120));
    ThemeData theme = ThemeData(colorScheme: colorScheme, useMaterial3: true);
	ThemeData darktheme = ThemeData(brightness: Brightness.dark);
	// ThemeData lighttheme = ThemeData(colorScheme: colorScheme, useMaterial3: true, brightness: Brightness.light);

    return MaterialApp(
		title: title, 
		theme: theme, 
		home: home, 
		darkTheme: darktheme, 
		debugShowCheckedModeBanner: false
		);
	}
	
}

// 