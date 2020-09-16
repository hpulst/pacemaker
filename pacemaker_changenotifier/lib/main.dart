import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/workout_repository.dart';
import 'screens/activity_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/home_screen.dart';
import 'util/key_value_storage.dart';

void main() {
  runApp(MyApp(
    repository: LocalStorageRepository(
      localStorage: KeyValueStorage(await SharedPreferences.getInstance()),
    ),
  ));
}

class MyApp extends StatelessWidget {
  final WorkoutsRepository repository;

  const MyApp({@required this.repository});

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
