import 'dart:convert';

import 'package:Pacemaker/models/workout_entity.dart';
import 'package:Pacemaker/models/workout_repository.dart';

/// Loads and saves a List of Todos using a provided KeyValueStore, which works
/// on mobile and web. On mobile, it uses the SharedPreferences package, on web
/// it uses window.localStorage.
///
/// Can be used as it's own repository, or mixed together with other storage
/// solutions, such as the the WebClient, which can be seen in the
/// LocalStorageRepository.

// class KeyValueStorage implements WorkoutsRepository {
//   final String key;
//   final KeyValueStore store;
//   final JsonCodec codec;

//   const KeyValueStorage(this.key, this.store, [this.codec = json]);

//   @override
//   Future<List<Workout>> loadTodos() async {
//     return codec
//         .decode(store.getString(key))['todos']
//         .cast<Map<String, Object>>()
//         .map<Workout>(Workout.fromJson)
//         .toList(growable: false);
//   }

//   @override
//   Future<bool> saveTodos(List<Workout> todos) {
//     return store.setString(
//       key,
//       codec.encode({
//         'todos': todos.map((todo) => todo.toJson()).toList(),
//       }),
//     );
//   }
// }
