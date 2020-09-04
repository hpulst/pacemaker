import 'dart:async';
import 'dart:core';

import 'workout_entity.dart';

abstract class WorkoutsRepository {
  // Loads workouts first from File storage.
  Future<List<WorkoutEntity>> loadWorkouts();

  // Persists workout to local disk
  Future saveWorkouts(List<WorkoutEntity> workouts);
}
