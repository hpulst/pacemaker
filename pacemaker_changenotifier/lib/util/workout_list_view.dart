import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/workout_list_model.dart';
import 'package:provider/provider.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'activity_tiles.dart';

class WorkoutListView extends StatefulWidget {
  const WorkoutListView({this.filename, this.complete, this.isExplore});

  final String filename;
  final bool complete;
  final bool isExplore;

  @override
  _WorkoutListViewState createState() => _WorkoutListViewState();
}

class _WorkoutListViewState extends State<WorkoutListView> {
  Widget _buildRemovedItem(
      Workout item, BuildContext context, Animation<double> animation) {
    return ActivityTile(
      complexObject: item,
      isExplore: widget.isExplore,
      animation: animation,
      // onComplete: () {}
      // No gesture detector here: we don't want removed items to be interactive.
    );
  }

  final listKey = GlobalKey<AnimatedListState>();
  ListModel<Workout> _list;

  @override
  Widget build(BuildContext context) {
    return Selector<WorkoutListModel, List<Workout>>(
      selector: (_, model) => model.filterWorkouts(widget.filename),
      builder: (context, workouts, _) {
        _list = ListModel<Workout>(
          listKey: listKey,
          initialItems: workouts,
          removedItemBuilder: _buildRemovedItem,
        );
        return AnimatedList(
          key: listKey,
          initialItemCount: workouts.length,
          itemBuilder: (context, index, animation) {
            final workout = workouts[index];
            // print(_list[index]);
            if (widget.isExplore) {
              return Column(
                children: [
                  ActivityTile(
                    complexObject: workout,
                    isExplore: widget.isExplore,
                    animation: animation,
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  if (workout.complete == widget.complete)
                    ActivityTile(
                      complexObject: workout,
                      isExplore: widget.isExplore,
                      animation: animation,
                      onComplete: () {
                        print('onComplete');
                        if (workout != null) {
                          if (workout.complete == false) {
                            _list.completeAt(_list.indexOf(workout));
                            print(workout);
                          } else {
                            _list.uncompleteAt(_list.indexOf(workout));
                          }
                        }
                      },
                    ),
                ],
              );
            }
          },
        );
      },
    );
  }
}

class ListModel<Workout> {
  ListModel({
    @required this.listKey,
    @required this.removedItemBuilder,
    Iterable<Workout> initialItems,
  })  : assert(listKey != null),
        assert(removedItemBuilder != null),
        _items = List<Workout>.from(initialItems ?? <Workout>[]);

  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<Workout> _items;

  AnimatedListState get _animatedList => listKey.currentState;

  Workout completeAt(int index) {
    print('Hi, whats going oin');
    final removedItem = _items[index];
    if (removedItem != null) {
      _animatedList.removeItem(
        index,
        (BuildContext context, Animation<double> animation) =>
            removedItemBuilder(removedItem, context, animation),
      );
    }
    return removedItem;
  }

  void uncompleteAt(int index) {
    _animatedList.insertItem(index);
  }

  int get length => _items.length;

  Workout operator [](int index) => _items[index];

  int indexOf(Workout item) => _items.indexOf(item);
}
