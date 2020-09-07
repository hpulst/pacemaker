import 'package:Pacemaker/screens/explore_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'models/workout_list_model.dart';
import 'models/workout_repository.dart';
import 'screens/activity_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WorkoutListModel(),
        ),
        // ChangeNotifierProxyProvider(create: null, update: null)
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
