import 'package:uuid/uuid.dart';

import 'workout_entity_model.dart';

class Workout {
  final String workout;
  final String id;
  final String week;
  final String weekday;
  final String km;
  final String time;
  final String pace;
  final String intensity;
  final String heartrate;
  final bool complete;

  Workout(
    this.workout, {
    this.week,
    this.weekday,
    this.km,
    this.time,
    this.pace,
    this.intensity,
    this.heartrate,
    this.complete = false,
    String id,
  }) : id = id ?? Uuid().v4();

  @override
  int get hashCode => id.hashCode;

  static Workout fromEntity(WorkoutEntity entity) {
    return Workout(
      entity.workout,
      week: entity.week,
      weekday: entity.weekday,
      km: entity.km,
      time: entity.time,
      pace: entity.pace,
      intensity: entity.intensity,
      heartrate: entity.heartrate,
      complete: entity.complete ?? false,
      id: entity.id,
    );
  }
}

// class WorkoutCatalog {
//   List<WorkoutItem> _workout;
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   Future fetchJSONWorkoutItems() async {
//     var parsedJson = jsonDecode(JsonMarathon.marathon330);
//     var deserializedObjects =
//         await parsedJson.map((o) => WorkoutItem.fromJson(o));
//     var listOfObjects = deserializedObjects.toList();

//     return listOfObjects;
//   }

//   Future loadWorkoutItems() {
//     return fetchJSONWorkoutItems().then((loadedWorkouts) {
//       _workout.addAll(loadedWorkouts.map(WorkoutItem()));
//       _isLoading = false;
//     }).catchError((err) {
//       _isLoading = false;
//     });
//   }
