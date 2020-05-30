import 'dart:async';
import 'package:flutter/widgets.dart';

class Workout {
  final int id;
  final String weekday;
  final String km;
  final String time;
  final String pace;
  final String intensity;
  final String heartrate;

  Workout(
      {this.id,
      this.weekday,
      this.km,
      this.time,
      this.pace,
      this.intensity,
      this.heartrate});

  // Convert a Workout into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'weekday': weekday,
      'km': km,
      'time': time,
      'pace': pace,
      'intensity': intensity,
      'heartrate': heartrate,
    };
  }
}
