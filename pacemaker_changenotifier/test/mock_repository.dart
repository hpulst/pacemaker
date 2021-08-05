import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/repository/workouts_repository.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';

class MockRepository implements WorkoutsRepository {
  MockRepository({List<Workout>? workouts, String? filename})
      : key = filename ?? '',
        entities = workouts?.map((item) => item.toEntity())?.toList();

  List<Workout>? entities;
  int saveCount = 0;

  final String key;

  @override
  Future<List<Workout>?> loadWorkouts(String? key) async => entities;

  @override
  Future saveWorkouts(List<Workout>? workouts, String? key) {
    entities = workouts;
    return Future<dynamic>.delayed(
      const Duration(seconds: 2),
      () => saveCount++,
    );
  }
}
