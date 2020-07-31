// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workout _$WorkoutFromJson(Map<String, dynamic> json) {
  return Workout(
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

Map<String, dynamic> _$WorkoutToJson(Workout instance) => <String, dynamic>{
      'order': instance.order,
      'workout': instance.workout,
      'week': instance.week,
      'weekday': instance.weekday,
      'km': instance.km,
      'time': instance.time,
      'pace': instance.pace,
      'intensity': instance.intensity,
      'heartrate': instance.heartrate,
      'complete': instance.complete,
    };
