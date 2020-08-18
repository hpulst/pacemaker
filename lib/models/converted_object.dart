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

class WorkoutObjectSimple {
  const WorkoutObjectSimple({
    this.name,
    this.workout,
    this.premarathon,
    this.pre10km,
    this.frequency,
  });

  final String name;
  final String workout;
  final String premarathon;
  final String pre10km;
  final String frequency;

  factory WorkoutObjectSimple.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return WorkoutObjectSimple(
      name: json['name'] as String,
      workout: json['workout'] as String,
      premarathon: json['premarathon'] as String,
      pre10km: json['pre10km'] as String,
      frequency: json['frequency'] as String,
    );
  }
}

class ConvertedComplexObject {
  const ConvertedComplexObject({
    this.aString,
    this.anInt,
    this.aDouble,
  });

  final String aString;
  final int anInt;
  final double aDouble;

  factory ConvertedComplexObject.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return ConvertedComplexObject(
      aString: json['aString'] as String,
      anInt: json['anInt'] as int,
      aDouble: json['aDouble'] as double,
    );
  }
}
