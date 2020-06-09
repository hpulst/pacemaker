// import 'dart:async';

// import 'package:Pacemaker/model/model.dart';
// import 'package:flutter/widgets.dart';

// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class WorkoutTable {
//   // Define a function that inserts workouts into the database
//   Future<void> insertTimeTable() async {
//     // Avoid errors caused by flutter upgrade.
//     // Importing 'package:flutter/widgets.dart' is required.
//     WidgetsFlutterBinding.ensureInitialized();
//     final database = openDatabase(
//       // Set the path to the database. Note: Using the `join` function from the
//       // `path` package is best practice to ensure the path is correctly
//       // constructed for each platform.
//       join(await getDatabasesPath(), 'workout_database.db'),
//       // When the database is first created, create a table to store workouts.
//       onCreate: (db, version) {
//         return db.execute(
//           "CREATE TABLE workouts(id INTEGER PRIMARY KEY, weekday TEXT, km TEXT, time TEXT, pace TEXT, intensity TEXT, heartrate TEXT)",
//         );
//       },
//       // Set the version. This executes the onCreate function and provides a
//       // path to perform database upgrades and downgrades.
//       version: 1,
//     );

//     Future<void> insertWorkout(Workout workout) async {
//       await insertTimeTable();
//       // Get a reference to the database.
//       final Database db = await database;

//       // Insert the workout into the correct table. Also specify the
//       // `conflictAlgorithm`. In this case, if the same workout is inserted
//       // multiple times, it replaces the previous data.
//       await db.insert(
//         'workouts',
//         workout.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );
//     }

//     print('hellohiere');

//     // A method that retrieves all the Workouts from the Workouts table.
//     Future<List<Workout>> workouts() async {
//       // Get a reference to the database.
//       final Database db = await database;

//       // Query the table for all The Workouts.
//       final List<Map<String, dynamic>> maps = await db.query('workouts');

//       // Convert the List<Map<String, dynamic> into a List<workouts>.
//       return List.generate(maps.length, (i) {
//         return Workout(
//           id: maps[i]['id'],
//           weekday: maps[i]['weekday'],
//           km: maps[i]['km'],
//           time: maps[i]['time'],
//           pace: maps[i]['pace'],
//           intensity: maps[i]['intensity'],
//           heartrate: maps[i]['heartrate'],
//         );
//       });
//     }

//     final fido = Workout(
//       id: 0,
//       weekday: 'So.',
//       km: '15km',
//       pace: '1:18 Std',
//       intensity: '5:10 min/km',
//       heartrate: '75-80%',
//     );
//     await insertWorkout(fido);

// // Now, use the method above to retrieve all the workouts.
//     print(await workouts());
//     print('waiting');
//   }
// }
