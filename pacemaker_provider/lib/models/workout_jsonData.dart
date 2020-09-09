import 'dart:convert';

import 'package:Pacemaker/data/json_strings_marathon.dart';
import 'package:Pacemaker/models/workout_entity.dart';
import 'package:Pacemaker/models/workout_repository.dart';

import 'converted_object.dart';

class JsonData implements WorkoutsRepository {
  JsonData();

  final parsedJson = jsonDecode(JsonMarathon.marathon330);

  @override
  Future<List<WorkoutEntity>> loadWorkouts() async {}

  final deserializedObjects =
      parsedJson.map((o) => WorkoutObjectComplex.fromJson(o));

  final listOfObjects = deserializedObjects.toList();

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  @override
  Future<bool> saveWorkouts(List<WorkoutEntity> workout) async {
    return Future.value(true);
  }
}
