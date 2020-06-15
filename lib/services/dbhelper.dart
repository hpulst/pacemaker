import 'dart:async';
import 'package:Pacemaker/model/model.dart';
import 'package:Pacemaker/model/workout_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class DBHelper {
  static Database _db;
  static int get _version => 1;
  static Future<void> init() async {
    if (_db != null) {
      return;
    }

    try {
      String _path = await getDatabasesPath() + 'workout_database';
      _db = await openDatabase(_path, version: _version, onCreate: onCreate);
    } catch (ex) {
      print(ex);
    }
  }

  static void onCreate(Database db, int version) async => await db.execute(
      'CREATE TABLE marathon(id INTEGER PRIMARY KEY NOT NULL, week TEXT, weekday TEXT, km TEXT, time TEXT, pace TEXT, intensity TEXT, heartrate TEXT, complete BIT)');

  static Future<List<Map<String, dynamic>>> query(String table) async =>
      _db.query(table);

  static Future<List<Map<String, dynamic>>> queryUncomplete(
          String table) async =>
      _db.query(table, where: "complete = ? ", whereArgs: ['false']);

  static Future<List<Map<String, dynamic>>> queryComplete(String table) async =>
      _db.query(table, where: "complete = ? ", whereArgs: [1]);

  static Future<int> insert(String table, Model model) async =>
      await _db.insert(
        table,
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

  static Future<int> update(String table, Model model) async => await _db
      .update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);

  static blockOrUnblock(Workout workout) async {
    final db = _db;
    Workout blocked = Workout(
        id: workout.id,
        week: workout.week,
        weekday: workout.weekday,
        km: workout.km,
        time: workout.time,
        pace: workout.pace,
        intensity: workout.intensity,
        heartrate: workout.heartrate,
        complete: !workout.complete);
    var res = await db.update(Workout.table, blocked.toMap(),
        where: "id = ?", whereArgs: [workout.id]);
    return res;
  }

  static Future<int> delete(String table, Model model) async =>
      await _db.delete(table, where: 'id = ?', whereArgs: [model.id]);

  static insertWorkouts(List workouts) async {
    var buffer = new StringBuffer();
    workouts.forEach((c) {
      if (buffer.isNotEmpty) {
        buffer.write(",\n");
      }
      buffer.write("('");
      buffer.write(c.week);
      buffer.write("', '");
      buffer.write(c.weekday);
      buffer.write("', '");
      buffer.write(c.km);
      buffer.write("', '");
      buffer.write(c.time);
      buffer.write("', '");
      buffer.write(c.pace);
      buffer.write("', '");
      buffer.write(c.intensity);
      buffer.write("', '");
      buffer.write(c.heartrate);
      buffer.write("', '");
      buffer.write(c.complete);
      buffer.write("')");
    });
    var raw = await _db.rawInsert(
        "INSERT Into marathon (week, weekday, km, time, pace, intensity, heartrate, complete)"
        " VALUES ${buffer.toString()}");
    print(raw);
  }
}
