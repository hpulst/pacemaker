import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/workout_list_model.dart';
import 'package:provider/provider.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'activity_tiles.dart';

class WorkoutListView extends StatelessWidget {
  const WorkoutListView({this.filename, this.complete, this.isExplore});
  final String filename;
  final bool complete;
  final bool isExplore;

  @override
  Widget build(BuildContext context) {
    return Selector<WorkoutListModel, List<Workout>>(
      selector: (_, model) => model.filterWorkouts(filename),
      builder: (context, workouts, _) {
        return ListView.builder(
          // padding: EdgeInsets.zero,
          itemCount: workouts.length,
          itemBuilder: (context, index) {
            final workout = workouts[index];
            if (isExplore) {
              return Column(
                children: [
                  ActivityTile(complexObject: workout, isExplore: true),
                ],
              );
            } else {
              return Column(
                children: [
                  if (workout.complete == complete)
                    ActivityTile(complexObject: workout, isExplore: false),
                ],
              );
            }
          },
        );
      },
    );
  }
}
