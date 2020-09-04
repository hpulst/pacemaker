import 'package:Pacemaker/models/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Workout.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        week = map['week'],
        weekday = map['weekday'],
        km = map['km'],
        time = map['time'],
        pace = map['pace'],
        intensity = map['intensity'],
        heartrate = map['heartrate'],
        complete = map['complete'];

  Workout.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data);
}
