import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'package:pacemaker_changenotifier/repository/key_value_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/storage_repository.dart';
import '../repository/workouts_repository.dart';

enum VisibilityFilter { all, active, completed }

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

  VisibilityFilter _filter;
  bool _isLoading = false;
  String filename;
  String _title;
  String _selected;

  String get title => _title;
  String get selected => _selected;
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
    }).catchError((dynamic err) {
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
    final oldWorkout = _workouts.firstWhere((e) => e.id == workout.id);
    final replaceIndex = _workouts.indexOf(oldWorkout);

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

  Future<List<Workout>> addWorkouts(String filename) async {
    var list = <Workout>[];
    list = _workouts.where((workout) => workout.workout == filename).toList();

    if (list.isEmpty) {
      final repo = await createRepo(filename);

      await repo.loadWorkouts(filename).then(
        (loadedWorkouts) {
          _workouts.addAll(loadedWorkouts.map(Workout.fromEntity));
        },
      );

      list = _workouts.where((workout) => workout.workout == filename).toList();
    }
    return list;
  }

  Future<LocalStorageRepository> createRepo(String filename) async {
    final repo = LocalStorageRepository(
        localStorage: KeyValueStorage(await SharedPreferences.getInstance()),
        filename: filename);
    return repo;
  }

  void setTitle() {
    _title = _workouts[0].workout;
    debugPrint(_title);
    notifyListeners();
  }

  Future setWorkout(Workout workout) async {
    const prefName = 'user';
    final prefs = await SharedPreferences.getInstance();

    _selected = prefs.getString(prefName) ?? workout.workout;
    await prefs.setString(prefName, workout.workout);

    // var repo = await createRepo(filename);

    // await repo.loadWorkouts(prefName).then(
    //   (loadedWorkouts) {
    //     _workouts.addAll(loadedWorkouts.map(Workout.fromEntity));
    //   },
    // );

    // var list = <Workout>[];
    // list.add(workout);

    // repository.saveWorkouts(
    //     list.map<Workout>((e) => e.toEntity()).toList(), prefName);

    // print(repository.saveWorkouts(
    //     list.map<Workout>((e) => e.toEntity()).toList(), prefName));
  }
}
