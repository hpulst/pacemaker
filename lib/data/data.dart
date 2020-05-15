import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TimeTable {
  final weekDay;
  final distance;
  final time;
  final heartRate;

  TimeTable({this.weekDay, this.distance, this.time, this.heartRate});

  // Define a function that inserts dogs into the database
  Future<void> insertTimeTable(TimeTable timeTable) async {
    // Get a reference to the database.
    // final Database db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    // await db.insert(
    //   'dogs',
    //   TimeTable.toMap(),
    //   conflictAlgorithm: ConflictAlgorithm.replace,
    // );
  }
}
