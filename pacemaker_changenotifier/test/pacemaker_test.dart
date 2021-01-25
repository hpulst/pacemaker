import 'package:pacemaker_changenotifier/models/workout_list_model.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'package:test/test.dart';

import 'mock_repository.dart';

void main() {
  group(
    'Pacemaker',
    () {
      test(
        'should check if there are completed workouts',
        () async {
          final model = WorkoutListModel(
            repository: MockRepository(),
            workouts: _defaultWorkouts,
          );
          model.setTitle('10Testing38', '10Testing38');
          expect(model.numCompleted, 1);
        },
      );
      test(
        'should check the number of workouts',
        () async {
          final model = WorkoutListModel(
            repository: MockRepository(),
            workouts: _defaultWorkouts,
          );
          model.setTitle('10Testing38', '10Testing38');
          expect(model.numLength, 3);
        },
      );
    },
  );
}

List<Workout> get _defaultWorkouts {
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
        complete: true),
  ];
}
