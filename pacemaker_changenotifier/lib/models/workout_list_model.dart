import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/explore_model.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'package:pacemaker_changenotifier/repository/key_value_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/storage_repository.dart';
import '../repository/workouts_repository.dart';

// enum VisibilityFilter { all, active, completed }

class WorkoutListModel extends ChangeNotifier {
  WorkoutListModel({
    @required this.repository,
    // VisibilityFilter filter,
    this.filename,
    List<Workout> workouts,
  }) : _workouts = workouts ?? [];
  // _filter = filter ?? VisibilityFilter.all;

  final WorkoutsRepository repository;
  final List<Workout> _workouts;

  // VisibilityFilter _filter;
  String filename;
  String _selectedWorkout = '';
  String _selectedTitle = 'Workout';
  bool _isLoading = false;

  String get selectedWorkout => _selectedWorkout;
  String get selectedTitle => _selectedTitle;
  // VisibilityFilter get filter => _filter;
  UnmodifiableListView<Workout> get workouts => UnmodifiableListView(_workouts);
  bool get isLoading => _isLoading;

  Future loadWorkouts() {
    _isLoading = true;
    notifyListeners();

    return repository.loadWorkouts(filename).then((loadedWorkouts) {
      _workouts.addAll(loadedWorkouts.map(Workout.fromEntity));
      _isLoading = false;
      notifyListeners();
    }).catchError((dynamic error) {
      _isLoading = false;
      notifyListeners();
      debugPrint('Error caught: $error');
    });
  }

  // List<Workout> get filteredWorkouts {
  //   return _workouts.where((workout) {
  //     switch (filter) {
  //       case VisibilityFilter.active:
  //         return !workout.complete;
  //         break;
  //       case VisibilityFilter.completed:
  //         return workout.complete;
  //         break;
  //       case VisibilityFilter.all:
  //       default:
  //         return true;
  //     }
  //   }).toList();
  // }

  List<Workout> filterWorkouts(String filename) {
    return _workouts.where((workout) => workout.workout == filename).toList();
  }

  void updateWorkout(Workout workout) {
    assert(workout != null);
    assert(workout.id != null);
    final oldWorkout = _workouts.firstWhere((e) => e.id == workout.id);
    final replaceIndex = _workouts.indexOf(oldWorkout);

    _workouts.replaceRange(replaceIndex, replaceIndex + 1, [workout]);
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

  Future<List<Workout>> addWorkouts(String filename) async {
    var _list = <Workout>[];
    _list = _workouts.where((workout) => workout.workout == filename).toList();
    if (_list.isEmpty) {
      final repo = await createRepository(filename);
      await repo.loadWorkouts(filename).then(
        (loadedWorkouts) {
          _list.addAll(loadedWorkouts.map(Workout.fromEntity));
        },
      );
      _workouts.addAll(_list);
    }
    return _list;
  }

  Future<LocalStorageRepository> createRepository(String filename) async {
    final repo = LocalStorageRepository(
        localStorage: KeyValueStorage(await SharedPreferences.getInstance()),
        filename: filename);
    return repo;
  }

  Future setWorkout(WorkoutTable workoutTable) async {
    // final name = workoutTable?.name?.substring(0, workoutTable.name.length - 4);
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('user', workoutTable.workout);
    await prefs.setString('title', workoutTable.name);

    _selectedWorkout = prefs.getString('user');
    _selectedTitle = prefs.getString('title');
    notifyListeners();
  }
}
