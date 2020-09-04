import 'dart:async';
import 'package:Pacemaker/model/model.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class DB {
  static Database _db;

  // static Future<void> init() async {
  //   // Avoid errors caused by flutter upgrade.
  //   WidgetsFlutterBinding.ensureInitialized();
  //   _db = await openDatabase(
  //     // Set the path to the database. Note: Using the `join` function from the
  //     // `path` package is best practice to ensure the path is correctly
  //     // constructed for each platform.
  //     join(await getDatabasesPath(), 'workout_database.db'),
  //     // When the database is first created, create a table to store workouts.
  //     onCreate: (db, version) {
  //       return db.execute(
  //         "CREATE TABLE marathon(id INTEGER PRIMARY KEY, weekday TEXT, km TEXT, time TEXT, pace TEXT, intensity TEXT, heartrate TEXT)",
  //       );
  //     },
  //     // Set the version. This executes the onCreate function and provides a
  //     // path to perform database upgrades and downgrades.
  //     version: 1,
  //   );
  // }

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
      'CREATE TABLE marathon (id INTEGER PRIMARY KEY NOT NULL, weekday STRING, km STRING, time STRING, pace STRING, intensity STRING, heartrate STRING, complete BOOLEAN)');

  static Future<List<Map<String, dynamic>>> query(String table) async =>
      _db.query(table);

  static Future<int> insert(String table, Model model) async =>
      await _db.insert(table, model.toMap());

  static Future<int> update(String table, Model model) async => await _db
      .update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);

  static Future<int> delete(String table, Model model) async =>
      await _db.delete(table, where: 'id = ?', whereArgs: [model.id]);

  void Batcher() async {
    Batch batch = _db.batch();

    batch.insert('Test', {'name': 'item'});
    batch.insert('Test', {'name': 'item'});
    batch.insert('Test', {'name': 'item'});
    batch.insert('Test', {'name': 'item'});
    batch.insert('Test', {'name': 'item'});

    await batch.commit(noResult: true);
  }
}
