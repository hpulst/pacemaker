import 'package:Pacemaker/models/workout_entity.dart';
import 'package:Pacemaker/models/workout_repository.dart';
import 'package:flutter/material.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Todos and Persist todos.
class LocalStorageRepository implements WorkoutsRepository {
  final WorkoutsRepository localStorage;

  const LocalStorageRepository({
    @required this.localStorage,
  });

  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  @override
  Future<List<WorkoutEntity>> loadWorkouts() async {
    try {
      return await localStorage.loadWorkouts();
    } catch (e) {}
  }

  // Persists todos to local disk and the web
  @override
  Future saveWorkouts(List<WorkoutEntity> todos) {
    return Future.wait<dynamic>([
      localStorage.saveWorkouts(todos),
    ]);
  }
}
