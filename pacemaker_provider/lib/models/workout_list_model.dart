import 'dart:collection';

import 'package:Pacemaker/models/workout_entity.dart';
import 'package:flutter/material.dart';

enum VisibilityFilter { all, active, completed }

class WorkoutListModel extends ChangeNotifier {
  // final WorkoutRepository repository;

  VisibilityFilter _filter;

  VisibilityFilter get filter => _filter;

  List<Workout> _workouts;

  UnmodifiableListView<Workout> get todos => UnmodifiableListView(_workouts);

  WorkoutListModel({
    VisibilityFilter filter,
    List<Workout> workouts,
  })  : _workouts = workouts ?? [],
        _filter = filter ?? VisibilityFilter.all;

  List<Workout> get filteredWorkouts {
    return _workouts.where((workout) {
      switch (filter) {
        case VisibilityFilter.active:
          return !workout.complete;
          break;
        case VisibilityFilter.completed:
          return workout.complete;
          break;
        case VisibilityFilter.all:
        default:
          return true;
      }
    }).toList();
  }
}
