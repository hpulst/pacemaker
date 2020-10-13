import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/workouts_repository.dart';
import 'package:pacemaker_changenotifier/util/json_import.dart';

import 'workout_model.dart';

class LocalStorageRepository implements WorkoutsRepository {
  final WorkoutsRepository localStorage;

  LocalStorageRepository({@required this.localStorage});

  WorkoutsRepository jsonClient = JsonImport();

  @override
  Future<List<Workout>> loadWorkouts() async {
    try {
      print('localStorage.loadWorkouts');
      return await localStorage.loadWorkouts();
    } catch (e) {
      final workouts = await jsonClient.loadWorkouts();
      await localStorage.saveWorkouts(workouts);
      return workouts;
    }
  }

  @override
  Future saveWorkouts(List<Workout> workouts) {
    return Future.wait<dynamic>(
      [
        localStorage.saveWorkouts(workouts),
      ],
    );
  }
}
