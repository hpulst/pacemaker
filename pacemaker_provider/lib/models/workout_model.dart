import 'package:Pacemaker/models/workout_entity.dart';
import 'package:uuid/uuid_util.dart';
import 'package:uuid/uuid.dart';

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
  //   static Workout fromEntity(WorkoutEntity entity) {
  //   return Workout(
  //     entity.task,
  //     complete: entity.complete ?? false,
  //     note: entity.note,
  //     id: entity.id,
  //   );
  // }
}
