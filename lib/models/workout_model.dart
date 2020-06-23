import 'package:Pacemaker/models/model.dart';

class Workout extends Model {
  static String table = 'marathon';

  final int id;
  final String week;
  final String weekday;
  final String km;
  final String time;
  final String pace;
  final String intensity;
  final String heartrate;
  bool complete;

  Workout(
      {this.id,
      this.week,
      this.weekday,
      this.km,
      this.time,
      this.pace,
      this.intensity,
      this.heartrate,
      this.complete});

  // Convert a Workout into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'week': week,
      'weekday': weekday,
      'km': km,
      'time': time,
      'pace': pace,
      'intensity': intensity,
      'heartrate': heartrate,
      'complete': complete,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static Workout fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'],
      week: map['week'],
      weekday: map['weekday'],
      km: map['km'],
      time: map['time'],
      pace: map['pace'],
      intensity: map['intensity'],
      heartrate: map['heartrate'],
      complete: map['complete'] == 1,
    );
  }
}
