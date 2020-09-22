import 'package:flutter/cupertino.dart';
import 'package:pacemaker_changenotifier/models/workouts_repository.dart';
import 'package:pacemaker_changenotifier/util/json_import.dart';

import 'workout_entity_model.dart';

class LocalStorageRepository implements WorkoutsRepository {
  final WorkoutsRepository localStorage;

  LocalStorageRepository({@required this.localStorage});

  WorkoutsRepository jsonClient = JsonImport();

  @override
  Future<List<WorkoutEntity>> loadWorkouts() async {
    try {
      return await localStorage.loadWorkouts();
    } catch (e) {
      final workouts = await jsonClient.loadWorkouts();
      print('workouts $workouts');
      await localStorage.saveWorkouts(workouts);
      return workouts;
    }
  }

  @override
  Future saveWorkouts(List<WorkoutEntity> workouts) {
    return Future.wait<dynamic>(
      [
        localStorage.saveWorkouts(workouts),
      ],
    );
  }
}
