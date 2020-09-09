class WorkoutObjectComplex {
  const WorkoutObjectComplex({
    this.order,
    this.workout,
    this.week,
    this.weekday,
    this.km,
    this.time,
    this.pace,
    this.intensity,
    this.heartrate,
    this.complete,
  });

  final int order;
  final String workout;
  final String week;
  final String weekday;
  final String km;
  final String time;
  final String pace;
  final String intensity;
  final String heartrate;
  final bool complete;

  factory WorkoutObjectComplex.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return WorkoutObjectComplex(
      order: json['order'] as int,
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
}
