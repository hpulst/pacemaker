import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/explore_model.dart';
import 'package:pacemaker_changenotifier/util/explore_tiles.dart';
import 'package:pacemaker_changenotifier/util/json_services.dart';

class ExploreTab extends StatelessWidget {
  final String filename;

  ExploreTab(this.filename);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WorkoutTableList>(
        future: loadWorkouts(filename),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SimpleObjectView(simpleObjects: snapshot.data.workouttables);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        });
  }
}
