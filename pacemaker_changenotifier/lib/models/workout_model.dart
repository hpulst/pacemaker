import 'package:uuid/uuid.dart';

import 'workout_entity_model.dart';

class Workout {
  Workout(
    this.workout, {
    String id,
    this.order,
    this.week,
    this.weekday,
    this.km,
    this.time,
    this.pace,
    this.intensity,
    this.heartrate,
    this.complete,
  }) : id = id ?? Uuid().v4();

  final String id;
  final String workout;
  final int order;
  final String week;
  final String weekday;
  final String km;
  final String time;
  final String pace;
  final String intensity;
  final String heartrate;
  final bool complete;

  @override
  int get hashCode => id.hashCode;

  factory Workout.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return Workout(
      json['workout'] as String,
      order: json['order'] as int,
      week: json['week'] as String,
      weekday: json['weekday'] as String,
      km: json['km'] as String,
      time: json['time'] as String,
      pace: json['pace'] as String,
      intensity: json['intensity'] as String,
      heartrate: json['heartrate'] as String,
      complete: json['complete'] as bool,
    );
  }
  static Workout fromEntity(WorkoutEntity entity) {
    return Workout(
      id: entity.id,
      entity.workout,
      entity.order,
      entity.week,
      entity.weekday,
      entity.km,
      entity.time,
      entity.pace,
      entity.intensity,
      entity.heartrate,
      complete: entity.complete ?? false,
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
