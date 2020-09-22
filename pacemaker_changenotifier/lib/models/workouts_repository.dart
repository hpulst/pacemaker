import 'dart:async';
import 'dart:core';

import 'package:pacemaker_changenotifier/models/workout_entity_model.dart';

abstract class WorkoutsRepository {
  // Loads workouts first from File storage.
  Future<List<WorkoutEntity>> loadWorkouts();

  // Persists workout to local disk
  Future saveWorkouts(List<WorkoutEntity> workouts);
}
