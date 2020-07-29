// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

class MarathonObject {
  const MarathonObject({
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

  factory MarathonObject.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return MarathonObject(
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

class MarathonObjectSimple {
  const MarathonObjectSimple({
    this.workout,
  });

  final String workout;

  factory MarathonObjectSimple.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return MarathonObjectSimple(
      workout: json['workout'] as String,
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
