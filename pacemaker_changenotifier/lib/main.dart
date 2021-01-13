// import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/workout_list_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'models/navigator_model.dart';
import 'page/explore_workouts_screen.dart';
import 'repository/key_value_storage.dart';
import 'repository/storage_repository.dart';
import 'repository/workouts_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final filename = prefs.getString('user');
  final title = prefs.getString('title');
  runApp(
    // DevicePreview(
    //   enabled: false,1
    //   builder: (context) =>
    MyApp(
      repository: LocalStorageRepository(localStorage: KeyValueStorage(prefs)),
      filename: filename,
      title: title,
    ),
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({@required this.repository, this.filename, this.title});

  final WorkoutsRepository repository;
  final String filename;
  final String title;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WorkoutListModel>(
          create: (_) => WorkoutListModel(repository: repository)
            ..loadWorkouts(filename)
            ..setTitle(filename, title),
        ),
        ChangeNotifierProvider<NavigatorModel>(
          create: (_) =>
              NavigatorModel()..currentIndex = (filename == null ? 2 : 0),
        ),
      ],
      child: MaterialApp(
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
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
        },
      ),
    );
  }
}
