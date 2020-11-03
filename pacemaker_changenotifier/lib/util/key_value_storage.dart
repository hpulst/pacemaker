import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'package:pacemaker_changenotifier/models/workouts_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStorage implements WorkoutsRepository {
  final SharedPreferences preferences;
  final JsonCodec codec;

  const KeyValueStorage(this.preferences, [this.codec = json]);

  @override
  Future<List<Workout>> loadWorkouts(String key) async {
    key = 'provider_workouts';

    debugPrint('KeyValueStorage: Key: $key');
    debugPrint(codec
        .decode(preferences.getString(key))['workouts']
        .cast<Map<String, Object>>()
        .map<Workout>(Workout.fromJson)
        .toList(growable: false));

    return codec
        .decode(preferences.getString(key))['workouts']
        .cast<Map<String, Object>>()
        .map<Workout>(Workout.fromJson)
        .toList(growable: false);
  }

  @override
  Future<bool> saveWorkouts(List<Workout> workouts, String key) {
    key = 'provider_workouts';
    return preferences.setString(
      key,
      codec.encode({
        'workouts': workouts.map((workout) => workout.toJson()).toList(),
      }),
    );
  }
}
