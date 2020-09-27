import 'dart:async';
import 'dart:core';

import 'workout_model.dart';

abstract class WorkoutsRepository {
  // Loads workouts first from File storage.
  Future<List<Workout>> loadWorkouts();

  // Persists workout to local disk
  Future saveWorkouts(List<Workout> workouts);
}
