import 'package:uuid/uuid.dart';

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
  bool complete;

  Workout({
    this.workout,
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

  static Workout fromEntity(Workout entity) {
    return Workout(
      workout: entity.workout,
      week: entity.week,
      weekday: entity.weekday,
      km: entity.km,
      time: entity.time,
      pace: entity.pace,
      intensity: entity.intensity,
      heartrate: entity.heartrate,
      complete: entity.complete ?? false,
    );
  }

  static Workout fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return Workout(
      workout: json['workout'] as String,
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

  Map<String, dynamic> toJson() {
    return {};
  }

  Workout copy({
    String workout,
    String id,
    String week,
    String weekday,
    String km,
    String time,
    String pace,
    String intensity,
    String heartrate,
    bool complete,
  }) {
    return Workout(
      workout: this.workout,
      id: this.id,
      week: this.week,
      weekday: this.weekday,
      km: this.km,
      time: this.time,
      pace: this.pace,
      intensity: this.intensity,
      heartrate: this.heartrate,
      complete: complete ?? this.complete,
    );
  }

  Workout toEntity() {
    return Workout(
      workout: workout,
      id: id,
      week: week,
      weekday: weekday,
      km: km,
      time: time,
      pace: pace,
      intensity: intensity,
      heartrate: heartrate,
      complete: complete ?? complete,
    );
  }
}
