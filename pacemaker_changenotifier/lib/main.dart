import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/workout_list_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'repository/key_value_storage.dart';
import 'repository/storage_repository.dart';
import 'repository/workouts_repository.dart';
import 'screens/explore_workouts_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('user');

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MyApp(
        repository:
            LocalStorageRepository(localStorage: KeyValueStorage(prefs)),
        token: token,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({@required this.repository, this.token});

  final WorkoutsRepository repository;
  final String token;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WorkoutListModel>(
          create: (_) =>
              WorkoutListModel(repository: repository)..loadWorkouts(),
        ),
        ChangeNotifierProvider<NavigatorModel>(
          create: (_) =>
              NavigatorModel()..currentIndex = (token == null ? 1 : 0),
        ),
      ],
      child: MaterialApp(
        locale: DevicePreview.of(context).locale,
        builder: DevicePreview.appBuilder,
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
        },
      ),
    );
  }
}

class NavigatorModel extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
