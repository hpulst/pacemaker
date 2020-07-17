import 'package:Pacemaker/models/workout_model.dart';
import 'package:flutter/material.dart';

class CardTile {
  static format(Workout item) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Text(
              item.weekday + '\n' + item.week,
              style: TextStyle(fontSize: 20.0),
            ),
            title: Text(item.km + '    ' + item.pace),
            subtitle: Text(item.time + '    ' + item.heartrate),
            trailing: Icon(Icons.drag_handle),
          ),
        ],
      ),
    );
  }
}
