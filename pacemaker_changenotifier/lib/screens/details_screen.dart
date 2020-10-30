import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/storage_repository.dart';
import 'package:pacemaker_changenotifier/models/workout_list_model.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'package:pacemaker_changenotifier/models/workouts_repository.dart';
import 'package:pacemaker_changenotifier/util/activity_tiles.dart';
import 'package:pacemaker_changenotifier/util/key_value_storage.dart';
import 'package:pacemaker_changenotifier/util/workout_list_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen(
      {Key key,
      this.name,
      this.workout,
      this.premarathon,
      this.pre10km,
      this.frequency})
      : super(key: key);

  final String name;
  final String workout;
  final String premarathon;
  final String pre10km;
  final String frequency;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

// repository:

class _DetailsScreenState extends State<DetailsScreen> {
  // var _displayBanner = true;

  Future loadWorkouts() async {
    // WorkoutListModel(
    //     repository: LocalStorageRepository(
    //         localStorage:
    //             KeyValueStorage(await SharedPreferences.getInstance())))..loadWorkouts();

    LocalStorageRepository repository = LocalStorageRepository(
        localStorage: KeyValueStorage(await SharedPreferences.getInstance()),
        filename: widget.workout);
    WorkoutListModel(repository: repository, filename: widget.workout)
      ..loadWorkouts();
    return repository;
  }

  @override
  Widget build(BuildContext context) {
    final banner = MaterialBanner(
      backgroundColor: new Color(0xFFFAFAFA),
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
          Text(widget.workout != null ? widget.workout : ''),
          Text(widget.premarathon != null
              ? widget.premarathon + '\n' + widget.pre10km
              : widget.pre10km),
          Text(widget.frequency != null ? widget.frequency : ''),
        ],
      ),
      actions: [
        _AddWorkouts(),
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
        title: Text(widget.name),
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
            future: loadWorkouts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return WorkoutListView(filename: widget.workout);
                // return ListView.builder(
                //     itemCount: snapshot.data.length,
                //     itemBuilder: (context, index) {
                //       return Column(
                //         children: [
                //           ComplexObjectView(snapshot.data[index]),
                //         ],
                //       );
                //     });
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}

class _AddWorkouts extends StatelessWidget {
  const _AddWorkouts({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text('Start'),
      onPressed: () {
        Navigator.pop(context);
        // Navigator.popAndPushNamed(context, '/schedule');
// https://stackoverflow.com/questions/55716230/how-to-do-nested-navigation-in-flutter
      },
    );
  }
}
