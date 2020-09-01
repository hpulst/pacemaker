import 'package:flutter/material.dart';

enum VisibilityFilter { all, active, completed }

class WorkoutListModel extends ChangeNotifier {
  // final WorkoutRepository repository;

  VisibilityFilter _filter;
  
  VisibilityFilter get filter => _filter;
  
  set filter(VisibilityFilter filter) {
    _filter = filter;
    notifyListeners();
  }




}
