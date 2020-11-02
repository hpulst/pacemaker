import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/workouts_repository.dart';
import 'package:pacemaker_changenotifier/util/json_services.dart';

import 'workout_model.dart';

class LocalStorageRepository implements WorkoutsRepository {
  final WorkoutsRepository localStorage;
  final String _filename;

  LocalStorageRepository({@required this.localStorage, String filename})
      : _filename = filename ?? '';

  WorkoutsRepository jsonClient = JsonImport();

  @override
  Future<List<Workout>> loadWorkouts(String key) async {
    try {
      print('Load SharedPreferences, Key: $key');
      return await localStorage.loadWorkouts(key);
    } catch (e) {
      print('Load JSON');
      final workouts = await jsonClient.loadWorkouts(key);
      print('saveWorkouts');
      await localStorage.saveWorkouts(workouts, key);

      return workouts;
    }
  }

  @override
  Future saveWorkouts(List<Workout> workouts, String key) {
    return Future.wait<dynamic>(
      [
        localStorage.saveWorkouts(workouts, key),
      ],
    );
  }
}

//TODO: How to check vor SharedPref getString instead of getInstance?
