import 'package:flutter/material.dart';

import 'screens/activity_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pacemaker',
      theme: ThemeData(
        primaryTextTheme: TextTheme(
          headline6: TextStyle(color: Colors.grey[800]),
        ),
        appBarTheme: AppBarTheme(
            color: Colors.white,
            iconTheme: IconThemeData(color: Colors.grey[800])),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // scaffoldBackgroundColor: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/schedule': (context) => ActivityScreen(),
        '/explore': (context) => ExploreScreen(),
      },
    );
  }
}
