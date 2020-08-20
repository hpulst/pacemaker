import 'package:flutter/material.dart';
import 'home.dart';
import 'screens/activity_screen.dart';

void main() => runApp(MyApp());

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
        // scaffoldBackgroundColor: Colors.red,
      ),
      routes: {
        '/schedule': (context) => ActivityScreen(0),
      },
      home: HomePage(),
    );
  }
}
