import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';

import 'workouts_repository.dart';

enum VisibilityFilter { all, active, completed }

class WorkoutListModel extends ChangeNotifier {
  final WorkoutsRepository repository;

  WorkoutListModel({
    @required this.repository,
    VisibilityFilter filter,
    List<Workout> workouts,
  })  : _workouts = workouts ?? [],
        _filter = filter ?? VisibilityFilter.all;

  VisibilityFilter _filter;
  bool _isLoading = false;
  List<Workout> _workouts;

  VisibilityFilter get filter => _filter;

  UnmodifiableListView<Workout> get workouts => UnmodifiableListView(_workouts);

  bool get isLoading => _isLoading;

  Future loadWorkouts() {
    _isLoading = true;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();

    return repository.loadWorkouts().then((loadedWorkouts) {
      _workouts.addAll(loadedWorkouts.map(Workout.fromEntity));
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

  void updateWorkout(Workout workout) {
    assert(workout != null);
    assert(workout.id != null);
    var oldWorkout = _workouts.firstWhere((e) => e.id == workout.id);
    print('oldWorkout ${oldWorkout.id}');
    var replaceIndex = _workouts.indexOf(oldWorkout);
    print('replaceIndex $replaceIndex');

    _workouts.replaceRange(replaceIndex, replaceIndex + 1, [workout]);

    print('What am I?: ${workout.complete}');

    notifyListeners();
    _uploadItems();
  }

  Workout workoutById(String id) {
    return _workouts.firstWhere((e) => e.id == id, orElse: () => null);
  }

  void _uploadItems() {
    repository.saveWorkouts(_workouts.map((e) => e.toEntity()).toList());
  }
}
