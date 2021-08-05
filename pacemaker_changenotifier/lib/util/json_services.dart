import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'package:pacemaker_changenotifier/repository/workouts_repository.dart';

class JsonImport implements WorkoutsRepository {
  @override
  Future<List<Workout>?> loadWorkouts(String? filename) async {
    String jsonWorkouts;
    List<Workout>? workoutTable = <Workout>[];

    try {
      jsonWorkouts = await _loadAsset(filename!);
      final List<dynamic>? parsedJson = await jsonDecode(jsonWorkouts);
      workoutTable =
          parsedJson?.map((dynamic o) => Workout.fromJson(o))?.toList();
    } catch (e, s) {
      debugPrint('Exception details inside _loadAsset:\n $e');
      debugPrint('Stack trace:\n $s');
    }

    return workoutTable;
  }

  Future<String> _loadAsset(String filename) async {
    final filePath = 'assets/json/' + filename + '.json';
    return await rootBundle.loadString(filePath);
  }

  @override
  Future<bool> saveWorkouts(List<Workout>? workouts, String? key) async {
    return Future.value(true);
  }
}
