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

//If workoutName == Null, load Workout provided/set by Provider

  @override
  Widget build(BuildContext context) {
    return Selector<WorkoutListModel, List<Workout>>(
      selector: (_, model) => model.filteredWorkouts,
      builder: (context, workouts, _) {
        return ListView.builder(
          itemCount: workouts.length,
          itemBuilder: (context, index) {
            final workout = workouts[index];
            if (complete == null) {
              return Column(
                children: [
                  if (workout.workout == filename) ComplexObjectView(workout),
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
