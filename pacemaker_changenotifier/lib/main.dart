// import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/workout_list_model.dart';
import 'package:pacemaker_changenotifier/screens/about_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'models/navigator_model.dart';
import 'repository/key_value_storage.dart';
import 'repository/storage_repository.dart';
import 'repository/workouts_repository.dart';
import 'screens/explore_workouts_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('user');
  final title = prefs.getString('title');
  runApp(
    // DevicePreview(
    //   enabled: false,1
    //   builder: (context) =>
    MyApp(
      repository: LocalStorageRepository(localStorage: KeyValueStorage(prefs)),
      token: token,
      title: title,
    ),
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({@required this.repository, this.token, this.title});

  final WorkoutsRepository repository;
  final String token;
  final String title;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WorkoutListModel>(
            create: (_) => WorkoutListModel(repository: repository)
              ..loadWorkouts()
              ..setTitle(token, title)),
        ChangeNotifierProvider<NavigatorModel>(
          create: (_) =>
              NavigatorModel()..currentIndex = (token == null ? 2 : 0),
        ),
      ],
      child: MaterialApp(
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: true,
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
        home: HomePage(),
        routes: {
          '/workouts': (context) => ExploreWorkouts(),
          '/about': (context) => AboutScreen(),
        },
      ),
    );
  }
}
