import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/workout_list_model.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'package:provider/provider.dart';
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
        return AnimatedWorkoutList(
            list: workouts, isExplore: isExplore, complete: complete);
      },
    );
  }
}

class AnimatedWorkoutList extends StatefulWidget {
  const AnimatedWorkoutList({
    @required this.list,
    @required this.isExplore,
    @required this.complete,
  });

  final List<Workout> list;
  final bool isExplore;
  final bool complete;

  @override
  _AnimatedWorkoutListState createState() => _AnimatedWorkoutListState();
}

class _AnimatedWorkoutListState extends State<AnimatedWorkoutList> {
  // Widget _buildRemovedItem(
  //     Workout item, BuildContext context, Animation<double> animation) {
  //   return ActivityTile(
  //     complexObject: item,
  //     isExplore: widget.isExplore,
  //     animation: animation,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const Key('__todoList__'),
      itemCount: widget.list.length,
      itemBuilder: (context, index) {
        final workout = widget.list[index];
        if (widget.isExplore) {
          return Column(
            children: [
              ActivityTile(
                complexObject: workout,
                isExplore: widget.isExplore,
                // animation: animation,
              ),
            ],
          );
        }
        return Column(
          children: [
            if (workout.complete == widget.complete)
              ActivityTile(
                key: Key('WorkoutItem_${workout.id}'),
                complexObject: workout,
                isExplore: widget.isExplore,
                // animation: animation,
                // onComplete: () {
                //   if (workout != null) {
                //     if (workout.complete == false) {
                //       final removedItem = workout;
                //       AnimatedList.of(context).removeItem(
                //         index,
                //         (context, animation) =>
                //             _buildRemovedItem(removedItem, context, animation),
                //       );
                //     }
                //   }
                // },
              ),
          ],
        );
      },
    );
  }
}
