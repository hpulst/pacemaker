import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pacemaker_changenotifier/home.dart';
import 'package:pacemaker_changenotifier/models/navigator_model.dart';
import 'package:pacemaker_changenotifier/models/workout_list_model.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'package:pacemaker_changenotifier/repository/workouts_repository.dart';
import 'package:provider/provider.dart';
import 'mock_repository.dart';

void main() {
  group('HomeScreen', () {
    testWidgets('should display a list after loading workouts',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const _TestWidget(
        filename: '10Testing38',
        title: '10 km in 38 min',
      ));
      await tester.pump(Duration.zero);
    });
    testWidgets(
        'should remove workout after using checkbox', (tester) async {});
    testWidgets('should display stats when switching tabs', (tester) async {});
  });
}

class _TestWidget extends StatelessWidget {
  const _TestWidget({
    Key key,
    this.repository,
    this.filename,
    this.title,
    this.workouts,
  }) : super(key: key);

  final WorkoutsRepository repository;
  final String filename;
  final String title;
  final List<Workout> workouts;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WorkoutListModel>(
          create: (_) {
            final repo = MockRepository(workouts ?? _defaultWorkouts);
            return WorkoutListModel(repository: repo)
              ..loadWorkouts(filename)
              ..setTitle(filename, title);
          },
        ),
        ChangeNotifierProvider<NavigatorModel>(
          create: (_) =>
              NavigatorModel()..currentIndex = (filename == null ? 2 : 0),
        ),
      ],
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }

  static List<Workout> get _defaultWorkouts {
    return [
      Workout(
          id: '1',
          workout: '10Testing38',
          week: 'Woche 1',
          weekday: 'Montag',
          km: 'Ruhetag',
          time: '',
          pace: '',
          intensity: '',
          heartrate: '',
          complete: true),
      Workout(
          id: '2',
          workout: '10Testing38',
          week: 'Woche 1',
          weekday: 'Dienstag',
          km: '15 km',
          time: '',
          pace: '',
          intensity: '',
          heartrate: '',
          complete: false),
      Workout(
          id: '3',
          workout: '10Testing38',
          week: 'Woche 1',
          weekday: 'Sonntag',
          km: '105 km',
          time: '',
          pace: '',
          intensity: '',
          heartrate: '',
          complete: false),
    ];
  }
}
