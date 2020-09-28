import 'dart:convert';
// import 'dart:html';

import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'package:pacemaker_changenotifier/models/workouts_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStorage implements WorkoutsRepository {
  final SharedPreferences preferences;
  final JsonCodec codec;

  const KeyValueStorage(this.preferences, [this.codec = json]);
  @override
  Future<List<Workout>> loadWorkouts() async {
    return codec
        .decode(preferences.getString('change_notifier_provider_workouts'))[
            'workouts']
        .map<Workout>(Workout.fromJson)
        .toList(growable: false);
  }

  @override
  Future<bool> saveWorkouts(List<Workout> workouts) {
    print('saveWorkouts');
    return preferences.setString(
      'change_notifier_provider_workouts',
      codec.encode({
        'workouts': workouts.map((workout) => workout.toJson()).toList(),
      }),
    );
  }
}
