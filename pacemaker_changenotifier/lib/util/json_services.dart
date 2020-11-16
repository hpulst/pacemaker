import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'package:pacemaker_changenotifier/repository/workouts_repository.dart';

class JsonImport implements WorkoutsRepository {
  @override
  Future<List<Workout>> loadWorkouts(String filename) async {
    String jsonWorkouts;
    try {
      jsonWorkouts = await _loadAsset(filename);
    } catch (e) {
      jsonWorkouts = await _loadAsset('marathon315');
    }

    final List<dynamic> parsedJson = await jsonDecode(jsonWorkouts);
    final workoutTable =
        parsedJson.map((dynamic o) => Workout.fromJson(o)).toList();
    return workoutTable;
  }

  Future<String> _loadAsset(String filename) async {
    final filePath = 'assets/json/' + filename + '.json';
    return await rootBundle.loadString(filePath);
  }

  @override
  Future<bool> saveWorkouts(List<Workout> workouts, String key) async {
    return Future.value(true);
  }
}
