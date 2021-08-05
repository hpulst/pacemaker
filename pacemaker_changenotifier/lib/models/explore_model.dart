import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class WorkoutTable {
  const WorkoutTable({
    this.name,
    this.workout,
    this.premarathon,
    this.pre10km,
    this.frequency,
  });

  factory WorkoutTable.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return WorkoutTable(
      name: json['name'],
      workout: json['workout'],
      premarathon: json['premarathon'],
      pre10km: json['pre10km'],
      frequency: json['frequency'],
    );
  }
  final String? name;
  final String? workout;
  final String? premarathon;
  final String? pre10km;
  final String? frequency;
}

Future<List<WorkoutTable>> loadWorkouts(String filename) async {
  final jsonWorkouts = await _loadAsset(filename);
  final List<dynamic> parsedJson = jsonDecode(jsonWorkouts);

  final workouttables =
      parsedJson.map((dynamic o) => WorkoutTable.fromJson(o)).toList();

  return workouttables;
}

Future<String> _loadAsset(String filename) async {
  final filePath = 'assets/json/' + filename + '.json';
  return await rootBundle.loadString(filePath);
}
