import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/workout_list_model.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'package:pacemaker_changenotifier/util/explore_tiles.dart';
import 'package:pacemaker_changenotifier/util/workout_list_view.dart';
import 'package:provider/provider.dart';

class ExploreWorkouts extends StatefulWidget {
  ExploreWorkouts({Key key}) : super(key: key);

  @override
  _ExploreWorkoutsState createState() => _ExploreWorkoutsState();
}

class _ExploreWorkoutsState extends State<ExploreWorkouts> {
  WorkoutListModel model;

  Future<List<Workout>> addWorkouts(String workout) async {
    model = Provider.of<WorkoutListModel>(context, listen: false);
    return await model.addWorkouts(workout);
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    final banner = MaterialBanner(
      backgroundColor: Color(0xFFFAFAFA),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Voraussetzung:\n',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
          Text(args.workout ?? ''),
          Text(args.premarathon != null
              ? args.premarathon + '\n' + args.pre10km
              : args.pre10km),
          Text(args.frequency ?? ''),
        ],
      ),
      actions: [
        _AddWorkouts(workout: args.workout, model: model),
        FlatButton(
          onPressed: () {},
          child: Text(
            'Reset',
          ),
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(args.name),
        centerTitle: true,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Container(
                child: banner,
              ),
            ),
          ];
        },
        body: FutureBuilder(
          future: addWorkouts(args.workout),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: CircularProgressIndicator(),
                    height: 30.0,
                    width: 30.0,
                  ),
                ],
              );
            }
            return WorkoutListView(filename: args.workout);
          },
        ),
      ),
    );
  }
}

class _AddWorkouts extends StatelessWidget {
  final String workout;
  final WorkoutListModel model;
  _AddWorkouts({
    this.workout,
    this.model,
    Key key,
  }) : super(key: key);

  List<Workout> list = [];

  // list.add[];

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text('Start'),
      onPressed: () {
        // Navigator.popAndPushNamed(context, '/schedule');
        Navigator.pop(context);
        model.setWorkout(list);
      },
    );
  }
}
