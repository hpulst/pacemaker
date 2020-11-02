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

  final String name;
  final String workout;
  final String premarathon;
  final String pre10km;
  final String frequency;

  factory WorkoutTable.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return WorkoutTable(
      name: json['name'] as String,
      workout: json['workout'] as String,
      premarathon: json['premarathon'] as String,
      pre10km: json['pre10km'] as String,
      frequency: json['frequency'] as String,
    );
  }
}

Future<List<WorkoutTable>> loadWorkouts(String filename) async {
  String jsonWorkouts = await _loadAsset(filename);
  List<dynamic> parsedJson = jsonDecode(jsonWorkouts);

  List<WorkoutTable> workouttables =
      parsedJson.map((o) => WorkoutTable.fromJson(o)).toList();

  return workouttables;
}

Future<String> _loadAsset(String filename) async {
  String filePath = "assets/json/" + filename + ".json";
  return await rootBundle.loadString(filePath);
}
