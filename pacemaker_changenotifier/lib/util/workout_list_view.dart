import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/workout_list_model.dart';
import 'package:provider/provider.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'activity_tiles.dart';

class WorkoutListView extends StatelessWidget {
  const WorkoutListView({this.filename, this.complete});
  final String filename;
  final bool complete;

  @override
  Widget build(BuildContext context) {
    print('Called WoroutListView');
    return Selector<WorkoutListModel, List<Workout>>(
      selector: (_, model) => model.filterWorkouts(filename),
      builder: (context, workouts, _) {
        return ListView.builder(
          itemCount: workouts.length,
          itemBuilder: (context, index) {
            final workout = workouts[index];
            if (complete == null) {
              return Column(
                children: [
                  ComplexObjectView(workout),
                ],
              );
            } else {
              return Column(
                children: [
                  if (workout.complete == complete) ComplexObjectView(workout),
                ],
              );
            }
          },
        );
      },
    );
  }
}
