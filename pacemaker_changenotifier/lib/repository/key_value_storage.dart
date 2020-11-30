import 'dart:convert';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'package:pacemaker_changenotifier/repository/workouts_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStorage implements WorkoutsRepository {
  const KeyValueStorage(this.preferences, [this.codec = json]);

  final SharedPreferences preferences;
  final JsonCodec codec;

  @override
  Future<List<Workout>> loadWorkouts(String key) async {
    return codec
        .decode(preferences.getString(key))['workouts']
        .cast<Map<String, Object>>()
        .map<Workout>(Workout.fromJson)
        .toList(growable: false);
  }

  @override
  Future<bool> saveWorkouts(List<Workout> workouts, String key) {
    return preferences.setString(
      key,
      codec.encode(
        {
          'workouts': workouts.map((workout) => workout.toJson()).toList(),
        },
      ),
    );
  }
}
