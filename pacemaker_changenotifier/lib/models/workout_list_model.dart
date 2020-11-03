import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'workouts_repository.dart';

enum VisibilityFilter { all, active, completed }

class WorkoutListModel extends ChangeNotifier {
  final WorkoutsRepository repository;
  VisibilityFilter _filter;
  bool _isLoading = false;
  final List<Workout> _workouts;
  String filename;
  String _pressed;
  String _title;
  String get title => _title;

  WorkoutListModel({
    @required this.repository,
    VisibilityFilter filter,
    this.filename,
    List<Workout> workouts,
  }) : _workouts = workouts ?? [];
  // _filter = filter ?? VisibilityFilter.all;

  VisibilityFilter get filter => _filter;
  UnmodifiableListView<Workout> get workouts => UnmodifiableListView(_workouts);
  bool get isLoading => _isLoading;
  String get pressed => _pressed;

  void setWorkout(String pressed) {
    _pressed = pressed;
    debugPrint('pressed  $pressed');
    notifyListeners();
  }

  Future loadWorkouts() {
    _isLoading = true;
    notifyListeners();
    return repository.loadWorkouts(filename).then((loadedWorkouts) {
      _workouts.addAll(loadedWorkouts.map(Workout.fromEntity));
      _isLoading = false;
      getTitle();
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
    var replaceIndex = _workouts.indexOf(oldWorkout);

    _workouts.replaceRange(replaceIndex, replaceIndex + 1, [workout]);
    // _workouts.removeWhere((it) => it.id == workout.id);

    notifyListeners();
    _uploadItems();
  }

  Workout workoutById(String id) {
    return _workouts.firstWhere((e) => e.id == id, orElse: () => null);
  }

  void _uploadItems() {
    debugPrint('_uploadItems');
    repository.saveWorkouts(
        _workouts.map<Workout>((e) => e.toEntity()).toList(),
        _workouts[0].workout);
  }

  void addWorkout(Workout workout) {
    _workouts.add(workout);
    notifyListeners();
    _uploadItems();
  }

  void getTitle() {
    _title = _workouts[0].workout;
    print('Title hi!');
    debugPrint(_title);
    notifyListeners();
  }
}
