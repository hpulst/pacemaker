import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pacemaker_changenotifier/models/explore_model.dart';

Future<WorkoutTableList> loadWorkouts(String filename) async {
  String jsonWorkouts = await _loadAsset(filename);
  final parsedJson = jsonDecode(jsonWorkouts);
  return WorkoutTableList.fromJson(parsedJson);
}

Future<String> _loadAsset(String filename) async {
  String filePath = "assets/json/" + filename + ".json";
  return await rootBundle.loadString(filePath);
}
