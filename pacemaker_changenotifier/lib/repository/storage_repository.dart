import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/repository/workouts_repository.dart';
import 'package:pacemaker_changenotifier/util/json_services.dart';

import '../models/workout_model.dart';

class LocalStorageRepository implements WorkoutsRepository {
  LocalStorageRepository({this.localStorage, String filename})
      : key = filename ?? '';

  final WorkoutsRepository localStorage;
  final String key;

  WorkoutsRepository jsonClient = JsonImport();

  @override
  Future<List<Workout>> loadWorkouts(String key) async {
    try {
      return await localStorage?.loadWorkouts(key);
    } catch (e) {
      final workouts = await jsonClient.loadWorkouts(key);
      await localStorage.saveWorkouts(workouts, key);
      // debugPrint('Load JSON');
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
