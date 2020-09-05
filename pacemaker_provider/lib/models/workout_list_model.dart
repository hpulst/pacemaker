import 'dart:collection';

import 'package:Pacemaker/models/workout_entity.dart';
import 'package:flutter/material.dart';

enum VisibilityFilter { all, active, completed }

class WorkoutListModel extends ChangeNotifier {
  WorkoutListModel({
    VisibilityFilter filter,
    List<Workout> workouts,
  })  : _workouts = workouts ?? [],
        _filter = filter ?? VisibilityFilter.all;

  // final WorkoutRepository repository;
  VisibilityFilter _filter;
  bool _isLoading = false;
  List<Workout> _workouts;

  VisibilityFilter get filter => _filter;

  UnmodifiableListView<Workout> get todos => UnmodifiableListView(_workouts);

  bool get isLoading => _isLoading;

  Future loadWorkouts() {
    _isLoading = true;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();

    return repository.loadTodos().then((loadedTodos) {
      _todos.addAll(loadedTodos.map(Todo.fromEntity));
      _isLoading = false;
      notifyListeners();
    }).catchError((err) {
      _isLoading = false;
      notifyListeners();
    });
  }

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
