import 'package:flutter/material.dart';

import 'package:pacemaker_changenotifier/models/explore_model.dart';
import 'package:pacemaker_changenotifier/models/workout_list_model.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'package:pacemaker_changenotifier/util/explore_tiles.dart';
import 'package:pacemaker_changenotifier/util/workout_list_view.dart';
import 'package:provider/provider.dart';

class ExploreWorkouts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    final banner = MaterialBanner(
      backgroundColor: const Color(0xFFFAFAFA),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Voraussetzung:\n',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
          Text(args.premarathon != null
              ? args.premarathon + '\n' + args.pre10km
              : args.pre10km),
          Text(args.frequency ?? ''),
        ],
      ),
      actions: [
        _AddWorkouts(workoutTable: args.workoutTable),
        FlatButton(
          onPressed: () {},
          child: const Text(
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
        body: FutureWorkouts(args: args),
      ),
    );
  }
}

class FutureWorkouts extends StatefulWidget {
  const FutureWorkouts({
    Key key,
    @required this.args,
  }) : super(key: key);

  final ScreenArguments args;
  @override
  _FutureWorkoutsState createState() => _FutureWorkoutsState();
}

class _FutureWorkoutsState extends State<FutureWorkouts> {
  // Future<List>>WorkoutListModel model = WorkoutListModel(repository: null);
  // Future<List<Workout>> workoutinstance;
  //     final model = Provider.of<WorkoutListModel>(context, listen: false);

  // @override
  // void initState() {
  //    workoutinstance = model.addWorkouts
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    Future<List<Workout>> addWorkouts(String workout) async {
      final model = Provider.of<WorkoutListModel>(context, listen: false);
      return await model.addWorkouts(workout);
    }

    return FutureBuilder(
      future: addWorkouts(widget.args.workout),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                child: CircularProgressIndicator(),
                height: 30.0,
                width: 30.0,
              ),
            ],
          );
        }
        return WorkoutListView(filename: widget.args.workout);
      },
    );
  }
}

class _AddWorkouts extends StatelessWidget {
  const _AddWorkouts({
    this.workoutTable,
    Key key,
  }) : super(key: key);

  final WorkoutTable workoutTable;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: const Text('Start'),
      onPressed: () {
        context.read<WorkoutListModel>().setWorkout(workoutTable);
        Navigator.pop(context);
        // Navigator.pushNamed(context, '/home'
        //     // , arguments: TabArguments(0)
        //     );
        // Provider.of<WorkoutListModel>(context, listen: false)
        //     .setWorkout(Workout(workout: name));
      },
    );
  }
}

// class TabArguments {
//   TabArguments(this.newTap);
//   final int newTap;
// }
