import 'dart:convert';

import 'package:pacemaker_changenotifier/data/json_strings_marathon.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'package:pacemaker_changenotifier/models/workouts_repository.dart';

class JsonImport implements WorkoutsRepository {
  final String workoutPath;

  JsonImport({this.workoutPath});

// TODO: If JSON == Null, declare: "Choose you workout!"
  @override
  Future<List<Workout>> loadWorkouts() async {
    print('workoutPath $workoutPath');
    List<dynamic> parsedJson = await jsonDecode(JsonMarathon.marathons);
    print('loadWorkouts JsonImport');
    // print(
    //   parsedJson
    //       .cast<Map<String, dynamic>>()
    //       .map<Workout>(Workout.fromJson)
    //       .toList(growable: false),
    // );
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
