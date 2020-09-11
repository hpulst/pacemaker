import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'activity_tiles.dart';

class WorkoutListView extends StatelessWidget {
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
            return Column(
              children: [
                ComplexObjectView(workout),
              ],
            );
          },
        );
      },
    );
  }
}
