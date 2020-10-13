import 'package:uuid/uuid.dart';

class Workout {
  final String id;
  final String workout;
  final String week;
  final String weekday;
  final String km;
  final String time;
  final String pace;
  final String intensity;
  final String heartrate;
  final bool complete;

  Workout({
    String id,
    this.workout,
    this.week,
    this.weekday,
    this.km,
    this.time,
    this.pace,
    this.intensity,
    this.heartrate,
    this.complete,
  }) : id = id ?? Uuid().v4();

  // @override
  // int get hashCode =>
  //     complete.hashCode ^
  //     workout.hashCode ^
  //     week.hashCode ^
  //     weekday.hashCode ^
  //     km.hashCode ^
  //     time.hashCode ^
  //     pace.hashCode ^
  //     intensity.hashCode ^
  //     heartrate.hashCode ^
  //     id.hashCode;

  // // @override
  // // bool operator ==(Object other) {
  // //   identical(this, other) ||
  // //       other is Workout &&
  // //           runtimeType == other.runtimeType &&
  // //           workout == other.workout &&
  // //           week == other.week &&
  // //           weekday == other.weekday &&
  // //           km == other.km &&
  // //           time == other.time &&
  // //           pace == other.pace &&
  // //           intensity == other.intensity &&
  // //           heartrate == other.heartrate &&
  // //           complete == other.complete &&
  // //           id == other.id;
  // // }

  static Workout fromEntity(Workout entity) {
    return Workout(
      id: entity.id,
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

  static Workout fromJson(Map<String, Object> json) {
    // if (json == null) return null;
    return Workout(
      id: Uuid().v4(),
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

  Map<String, Object> toJson() {
    return {
      'id': id,
      'workout': workout,
      'week': week,
      'weekday': weekday,
      'km': km,
      'time': time,
      'pace': pace,
      'intensity': intensity,
      'heartrate': heartrate,
      'complete': complete,
    };
  }

  Workout copy({
    String id,
    String workout,
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
      id: this.id,
      workout: this.workout,
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

  @override
  String toString() {
    return 'Workout{id: $id, workout: $workout, week: $week, weekday: $weekday, km: $km, time: $time, pace: $pace, intensity: $intensity, heartrate: $heartrate, complete: $complete}';
  }

  Workout toEntity() {
    return Workout(
      id: id,
      workout: workout,
      week: week,
      weekday: weekday,
      km: km,
      time: time,
      pace: pace,
      intensity: intensity,
      heartrate: heartrate,
      complete: complete,
    );
  }
}
