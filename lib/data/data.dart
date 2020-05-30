import 'dart:async';

import 'package:Pacemaker/model/model.dart';
import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataTable {
  // Define a function that inserts workouts into the database
  Future<void> insertTimeTable(DataTable dataTable) async {
    // Avoid errors caused by flutter upgrade.
    // Importing 'package:flutter/widgets.dart' is required.
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'workout_database.db'),
      // When the database is first created, create a table to store workouts.
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE workouts(id INTEGER PRIMARY KEY, weekday TEXT, km TEXT, time TEXT, pace TEXT, intensity TEXT, heartrate TEXT)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

    Future<void> insertWorkout(Workout workout) async {
      // Get a reference to the database.
      final Database db = await database;

      // Insert the workout into the correct table. Also specify the
      // `conflictAlgorithm`. In this case, if the same workout is inserted
      // multiple times, it replaces the previous data.
      await db.insert(
        'workouts',
        workout.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}
