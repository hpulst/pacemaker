import 'package:Pacemaker/models/workout_jsonData.dart';
import 'package:Pacemaker/models/workout_model.dart';
import 'package:Pacemaker/models/workout_repository.dart';
import 'package:flutter/material.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Todos and Persist todos.
class LocalStorageRepository implements WorkoutsRepository {
  final WorkoutsRepository localStorage;
  final WorkoutsRepository jsonData;

  const LocalStorageRepository({
    @required this.localStorage,
    this.jsonData = const JsonData(),
  });

  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  @override
  Future<List<Workout>> loadWorkouts() async {
    try {
      return await localStorage.loadWorkouts();
    } catch (e) {
      final workouts = await jsonData.loadWorkouts();

      await localStorage.saveWorkouts(workouts);

      return workouts;
    }
  }

  // Persists todos to local disk and the web
  @override
  Future saveWorkouts(List<Workout> todos) {
    return Future.wait<dynamic>([
      localStorage.saveWorkouts(todos),
    ]);
  }
}

/// A class that is meant to represent a Client that would be used to call a Web
/// Service. It is responsible for fetching and persisting Todos to and from the
/// cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
// class WebClient implements TodosRepository {
//   final Duration delay;

//   const WebClient([this.delay = const Duration(milliseconds: 3000)]);

//   /// Mock that "fetches" some Todos from a "web service" after a short delay
//   @override
//   Future<List<TodoEntity>> loadTodos() async {
//     return Future.delayed(
//         delay,
//         () => [
//               TodoEntity(
//                 'Buy food for da kitty',
//                 '1',
//                 'With the chickeny bits!',
//                 false,
//               ),
//               TodoEntity(
//                 'Find a Red Sea dive trip',
//                 '2',
//                 'Echo vs MY Dream',
//                 false,
//               ),
//               TodoEntity(
//                 'Book flights to Egypt',
//                 '3',
//                 '',
//                 true,
//               ),
//               TodoEntity(
//                 'Decide on accommodation',
//                 '4',
//                 '',
//                 false,
//               ),
//               TodoEntity(
//                 'Sip Margaritas',
//                 '5',
//                 'on the beach',
//                 true,
//               ),
//             ]);
//   }

//   /// Mock that returns true or false for success or failure. In this case,
//   /// it will "Always Succeed"
//   @override
//   Future<bool> saveTodos(List<TodoEntity> todos) async {
//     return Future.value(true);
//   }
// }
