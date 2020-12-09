import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/workout_list_model.dart';
import 'package:provider/provider.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'activity_tiles.dart';

class WorkoutListView extends StatefulWidget {
  const WorkoutListView(
      {this.filename, this.complete, this.isExplore, this.listKey});

  final String filename;
  final bool complete;
  final bool isExplore;
  final GlobalKey<AnimatedListState> listKey;

  @override
  _WorkoutListViewState createState() => _WorkoutListViewState();
}

class _WorkoutListViewState extends State<WorkoutListView> {
  // var listKey = GlobalKey<AnimatedListState>();
  // @override
  // void deactivate() {
  //   if (listKey.currentState != null) {
  //     listKey.currentState.dispose();
  //     print('dispose disposal');
  //   }
  //   super.deactivate();
  //   print('deactivate ${_list}');
  // }

  @override
  void didUpdateWidget(Widget oldWidget) {
    ListModel<Workout>().disposeState();

    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget inside activity');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose disposal');
  }

  Widget _buildRemovedItem(
      Workout item, BuildContext context, Animation<double> animation) {
    return ActivityTile(
      complexObject: item,
      isExplore: widget.isExplore,
      animation: animation,
    );
  }

  @override
  Widget build(BuildContext context) {
    ListModel<Workout> _list;
    return Selector<WorkoutListModel, List<Workout>>(
      selector: (_, model) => model.filterWorkouts(widget.filename),
      builder: (context, workouts, _) {
        // create a listmodel
        // _list = ListModel<Workout>(
        //   listKey: listKey,
        //   initialItems: workouts,
        //   removedItemBuilder: _buildRemovedItem,
        // );
        return AnimatedList(
          initialItemCount: workouts.length,
          itemBuilder: (context, index, animation) {
            final workout = workouts[index];
            print('listKey currentstate ${AnimatedList.of(context).widget}');
            // print('listKey  $listKey');
            print('workouts length ${workouts.length} vs ');
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
                        if (workout != null) {
                          if (workout.complete == false) {
                            _list.completeAt(_list.indexOf(workout));
                          } else {
                            final index = workout == null
                                ? _list.length
                                : _list.indexOf(workout);
                            _list.uncompleteAt(
                              index,
                            );
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
    this.listKey,
    this.removedItemBuilder,
    Iterable<Workout> initialItems,
  }) :

        // assert(listKey != null),
        //       assert(removedItemBuilder != null),
        _items = List<Workout>.from(initialItems ?? <Workout>[]);

  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<Workout> _items;

  AnimatedListState get animatedList => listKey?.currentState;

  Workout completeAt(int index) {
    print(animatedList);
    final removedItem = _items[index];
    if (removedItem != null) {
      animatedList.removeItem(
        index,
        (BuildContext context, Animation<double> animation) =>
            removedItemBuilder(removedItem, context, animation),
      );
    }
    return removedItem;
  }

  void uncompleteAt(int index) {
    animatedList.insertItem(index);
  }

  void disposeState() {
    if (animatedList != null) {
      animatedList.dispose();
      print('final destruction');
    }
  }

  int get length => _items.length;

  Workout operator [](int index) => _items[index];

  int indexOf(Workout item) => _items.indexOf(item);
}
