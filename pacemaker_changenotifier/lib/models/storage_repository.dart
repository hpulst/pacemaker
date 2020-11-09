import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/workouts_repository.dart';
import 'package:pacemaker_changenotifier/util/json_services.dart';

import 'workout_model.dart';

class LocalStorageRepository implements WorkoutsRepository {
  final WorkoutsRepository localStorage;
  final String key;

  LocalStorageRepository({this.localStorage, String filename})
      : key = filename ?? '';

  WorkoutsRepository jsonClient = JsonImport();

  @override
  Future<List<Workout>> loadWorkouts(String key) async {
    try {
      return await localStorage?.loadWorkouts(key);
    } catch (e) {
      debugPrint('Load JSON');
      final workouts = await jsonClient.loadWorkouts(key);
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
