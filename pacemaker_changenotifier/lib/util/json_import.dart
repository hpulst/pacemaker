import 'dart:convert';

import 'package:pacemaker_changenotifier/data/json_strings_marathon.dart';
import 'package:pacemaker_changenotifier/models/workout_entity_model.dart';
import 'package:pacemaker_changenotifier/models/workouts_repository.dart';

class JsonImport implements WorkoutsRepository {
  @override
  Future<List<WorkoutEntity>> loadWorkouts() async {
    List<dynamic> parsedJson = await jsonDecode(JsonMarathon.marathon330);
    return parsedJson
        .cast<Map<String, dynamic>>()
        .map<WorkoutEntity>(WorkoutEntity.fromJson)
        .toList(growable: false);
//     return Future(
//       () => [
//         WorkoutEntity(
//             id: "0",
//             workout: "marathon315",
//             week: "Woche 1",
//             weekday: "Montag",
//             km: "Ruhetag",
//             complete: false),
//         WorkoutEntity(
//             id: "1",
//             workout: "marathon315",
//             week: "Woche 1",
//             weekday: "Dienstag",
//             km: "15 km",
//             time: "1:23 Std",
//             pace: "05:30 min/km",
//             intensity: "LD",
//             heartrate: "70%-75%",
//             complete: false),
//         WorkoutEntity(
//             id: "2",
//             workout: "marathon315",
//             week: "Woche 1",
//             weekday: "Mittwoch",
//             km: "15 km",
//             time: "1:23 Std",
//             pace: "05:30 min/km",
//             intensity: "SD",
//             heartrate: "80%-85%",
//             complete: false),
//       ],
//     );
//   }
  }

  @override
  Future<bool> saveWorkouts(List<WorkoutEntity> workouts) async {
    return Future.value(true);
  }
}
