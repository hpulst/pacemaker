import 'dart:convert';
// import 'dart:html';

import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'package:pacemaker_changenotifier/models/workouts_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStorage implements WorkoutsRepository {
  final SharedPreferences preferences;
  final JsonCodec codec;

  const KeyValueStorage(this.preferences, [this.codec = json]);
  @override
  Future<List<Workout>> loadWorkouts() async {
    // print(codec
    //     .decode(preferences.getString('change_notifier_provider_workouts'))[
    //         'workouts']
    //     .cast<Map<String, Object>>()
    //     .map<Workout>(Workout.fromJson)
    //     .toList(growable: false));

    return codec
        .decode(preferences.getString('change_notifier_provider_workouts'))[
            'workouts']
        .cast<Map<String, Object>>()
        .map<Workout>(Workout.fromJson)
        .toList(growable: false);
  }

  @override
  Future<bool> saveWorkouts(List<Workout> workouts) {
    // var i = preferences.setString(
    //   'change_notifier_provider_workouts',
    //   codec.encode({
    //     'workouts': workouts.map((workout) => workout.toJson()).toList(),
    //   }),
    // );
    // print('saveWorkouts');
    // print(
    //   codec.encode({
    //     'workouts': workouts.map((workout) => workout.toJson()).toList(),
    //   }),
    // );
    // print('loadWorkouts');
    // print(
    //   codec
    //       .decode(preferences.getString('change_notifier_provider_workouts'))[
    //           'workouts']
    //       .cast<Map<String, Object>>()
    //       .map<Workout>(Workout.fromJson)
    //       .toList(growable: false),
    // );

    // print(workouts.map((workout) => workout.toJson()).toList());

    return preferences.setString(
      'change_notifier_provider_workouts',
      codec.encode({
        'workouts': workouts.map((workout) => workout.toJson()).toList(),
      }),
    );
  }
}
