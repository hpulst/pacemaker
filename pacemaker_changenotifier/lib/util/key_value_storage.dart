import 'dart:convert';
// import 'dart:html';

import 'package:pacemaker_changenotifier/models/workout_entity_model.dart';
import 'package:pacemaker_changenotifier/models/workouts_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStorage implements WorkoutsRepository {
  final SharedPreferences preferences;
  final JsonCodec codec;

  const KeyValueStorage(this.preferences, [this.codec = json]);
  @override
  Future<List<WorkoutEntity>> loadWorkouts() async {
    return codec
        .decode(preferences.getString('change_notifier_provider_workouts'))[
            'workouts']
        .map<WorkoutEntity>(WorkoutEntity.fromJson)
        .toList(growable: false);
  }

  @override
  Future<bool> saveWorkouts(List<WorkoutEntity> workouts) {
    return preferences.setString(
      'change_notifier_provider_workouts',
      codec.encode({
        'workouts': workouts.map((workout) => workout.toJson()).toList(),
      }),
    );
  }
}
