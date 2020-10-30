import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/workout_list_model.dart';
import 'package:provider/provider.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'activity_tiles.dart';

class WorkoutListView extends StatelessWidget {
  final String filename;
  final bool complete;
  WorkoutListView({this.filename, this.complete});

//If workoutName =! Null load Json or already saved Workout
//Workout erst saven wenn

//If workoutName == Null, load Workout provided/set by Provider

  // WorkoutsRepository workouts = LocalStorageRepository(
  //     localStorage: KeyValueStorage(await SharedPreferences.getInstance()),
  //     filename: filename);

  @override
  Widget build(BuildContext context) {
    return Selector<WorkoutListModel, List<Workout>>(
      selector: (_, model) => model.filteredWorkouts,
      builder: (context, workouts, _) {
        // print('Selector<WorkoutListModel');
        // print('workouts.runtimeType: ${workouts.runtimeType}');
        // print('workouts.length: ${workouts.length}');

        return ListView.builder(
          itemCount: workouts.length,
          itemBuilder: (context, index) {
            // print('ListView.builder');
            final workout = workouts[index];
            if (complete == null) {
              // print('ComplexObjectView(workout)');
              return Column(
                children: [
                  ComplexObjectView(workout),
                ],
              );
            } else {
              return Column(
                children: [
                  if (workout.workout == filename &&
                      workout.complete == complete)
                    ComplexObjectView(workout),
                ],
              );
            }
          },
        );
      },
    );
  }
}
