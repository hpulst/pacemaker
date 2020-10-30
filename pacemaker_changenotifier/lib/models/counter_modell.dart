import 'package:flutter/cupertino.dart';

class Counter with ChangeNotifier {
  String _workout;
  String get workout => _workout;

  void setWorkout(String workout) {
    _workout = workout;
    // print('workout  $workout');
    notifyListeners();
  }
}
