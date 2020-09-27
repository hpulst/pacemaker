import 'dart:convert';

import 'package:pacemaker_changenotifier/data/json_strings_marathon.dart';
import 'package:pacemaker_changenotifier/models/workout_entity_model.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'package:pacemaker_changenotifier/models/workouts_repository.dart';

class JsonImport implements WorkoutsRepository {
  @override
  Future<List<Workout>> loadWorkouts() async {
    List<dynamic> parsedJson = await jsonDecode(JsonMarathon.marathons);
    return parsedJson
        .cast<Map<String, dynamic>>()
        .map<Workout>(Workout.fromJson)
        .toList(growable: false);
  }

  @override
  Future<bool> saveWorkouts(List<Workout> workouts) async {
    return Future.value(true);
  }
}
