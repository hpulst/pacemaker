import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/workout_list_model.dart';
import 'package:provider/provider.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'activity_tiles.dart';

class WorkoutListView extends StatelessWidget {
  final String workoutName;
  final bool complete;
  const WorkoutListView({this.workoutName, this.complete});

  @override
  Widget build(BuildContext context) {
    return Selector<WorkoutListModel, List<Workout>>(
      selector: (_, model) => model.filteredWorkouts,
      builder: (context, workouts, _) {
        return ListView.builder(
          // key: Key,
          itemCount: workouts.length,
          itemBuilder: (context, index) {
            final workout = workouts[index];
            if (complete == null) {
              return Column(
                children: [
                  if (workout.workout == workoutName)
                    ComplexObjectView(workout),
                ],
              );
            } else {
              return Column(
                children: [
                  if (workout.workout == workoutName &&
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
