import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'package:pacemaker_changenotifier/util/key_value_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'storage_repository.dart';
import 'workouts_repository.dart';

enum VisibilityFilter { all, active, completed }

class WorkoutListModel extends ChangeNotifier {
  final WorkoutsRepository repository;
  final List<Workout> _workouts;

  VisibilityFilter _filter;
  bool _isLoading = false;
  String filename;
  String _title;

  WorkoutListModel({
    @required this.repository,
    VisibilityFilter filter,
    this.filename,
    List<Workout> workouts,
  }) : _workouts = workouts ?? [];
  // _filter = filter ?? VisibilityFilter.all;

  String get title => _title;
  VisibilityFilter get filter => _filter;
  UnmodifiableListView<Workout> get workouts => UnmodifiableListView(_workouts);
  bool get isLoading => _isLoading;

  Future loadWorkouts() {
    _isLoading = true;
    notifyListeners();
    return repository.loadWorkouts(filename).then((loadedWorkouts) {
      _workouts.addAll(loadedWorkouts.map(Workout.fromEntity));
      _isLoading = false;
      setTitle();
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
    repository.saveWorkouts(
        _workouts.map<Workout>((e) => e.toEntity()).toList(),
        _workouts[0].workout);
  }

  Future<List<Workout>> addWorkouts(filename) async {
    var list = <Workout>[];
    list = _workouts.where((workout) => workout.workout == filename).toList();

    if (list.isEmpty) {
      var repo = LocalStorageRepository(
          localStorage: KeyValueStorage(await SharedPreferences.getInstance()),
          filename: filename);

      await repo.loadWorkouts(filename).then(
        (loadedWorkouts) {
          _workouts.addAll(loadedWorkouts.map(Workout.fromEntity));
        },
      );

      list = _workouts.where((workout) => workout.workout == filename).toList();
    }
    return list;
  }

  void setTitle() {
    _title = _workouts[0].workout;
    debugPrint(_title);
    notifyListeners();
  }

  void setWorkout(List workout) {
    repository.saveWorkouts(workout, 'user');
  }
}
