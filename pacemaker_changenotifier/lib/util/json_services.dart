import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'package:pacemaker_changenotifier/models/workouts_repository.dart';

class JsonImport implements WorkoutsRepository {
  @override
  Future<List<Workout>> loadWorkouts(String filename) async {
    String jsonWorkouts;
    try {
      jsonWorkouts = await _loadAsset(filename);
      debugPrint('workoutPath $filename');
    } catch (e) {
      jsonWorkouts = await _loadAsset('marathon315');
    }

    List<dynamic> parsedJson = await jsonDecode(jsonWorkouts);
    List<Workout> workoutTable =
        parsedJson.map((o) => Workout.fromJson(o)).toList();
    return workoutTable;
  }

  Future<String> _loadAsset(String filename) async {
    var filePath = 'assets/json/' + filename + '.json';
    return await rootBundle.loadString(filePath);
  }

  @override
  Future<bool> saveWorkouts(List<Workout> workouts, String key) async {
    return Future.value(true);
  }
}
