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
    final workoutListFinder = find.descendant(
        of: find.byKey(const Key('__todoList__')),
        matching: find.byType(AnimatedList));
    final workoutItem1Finder = find.byKey(const Key('WorkoutItem_1'));
    final workoutItem2Finder = find.byKey(const Key('WorkoutItem_2'));
    final workoutItem3Finder = find.byKey(const Key('WorkoutItem_2'));

    testWidgets('should display a list after loading workouts',
        (WidgetTester tester) async {
      await tester.pumpWidget(const _TestWidget());
      await tester.pump(Duration.zero);

      final checkbox1 = find.descendant(
          of: find.byKey(const Key('WorkoutItem__${1}__Checkbox')),
          matching: find.byType(Focus));

      expect(workoutListFinder, findsOneWidget);
      expect(workoutItem1Finder, findsNothing);
      expect(find.text('Ruhetag'), findsNothing);
      expect(workoutItem3Finder, findsNothing);
      expect(tester.getSemantics(checkbox1), isChecked(false));
    });

    testWidgets('should remove workout after using checkbox', (tester) async {
      await tester.pumpWidget(const _TestWidget());
      await tester.pumpAndSettle(const Duration(seconds: 5));
      await tester.tap(find.byKey(const Key('WorkoutItem__${1}__Checkbox')));
      await tester.pumpAndSettle(const Duration(seconds: 5));
      expect(workoutItem1Finder, findsNothing);
    });
    testWidgets('should display stats when switching tabs', (tester) async {
      await tester.pumpWidget(const _TestWidget());
      await tester.pump(Duration.zero);
      await tester.tap(find.byKey(const Key('__statsTab__')));

      expect(
          find.byKey(const Key('__circularPercentIndicator__')), findsWidgets);
    });
  });
}

class _TestWidget extends StatelessWidget {
  const _TestWidget({
    this.repository,
    String filename,
    String title,
    this.workouts,
  })  : filename = filename ?? '10Testing38',
        title = title ?? '10 km in 38 min';

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
            final repo = MockRepository(workouts: workouts ?? _defaultWorkouts);
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
          complete: false),
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

Matcher isChecked(bool isChecked) {
  return matchesSemantics(
    isChecked: isChecked,
    hasCheckedState: true,
    hasEnabledState: true,
    isEnabled: true,
    isFocusable: true,
    hasTapAction: true,
  );
}
