import 'dart:convert';

import 'package:pacemaker_changenotifier/data/json_strings_marathon.dart';
import 'package:pacemaker_changenotifier/models/workout_entity_model.dart';
import 'package:pacemaker_changenotifier/models/workouts_repository.dart';

class JsonImport implements WorkoutsRepository {
  @override
  Future<List<WorkoutEntity>> loadWorkouts() async {
    List<dynamic> parsedJson = await jsonDecode(JsonMarathon.marathons);
    return parsedJson
        .cast<Map<String, dynamic>>()
        .map<WorkoutEntity>(WorkoutEntity.fromJson)
        .toList(growable: false);
  }

  @override
  Future<bool> saveWorkouts(List<WorkoutEntity> workouts) async {
    return Future.value(true);
  }
}
