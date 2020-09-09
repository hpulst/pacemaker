import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/workout_plan.dart';
import 'package:pacemaker_changenotifier/util/activity_tiles.dart';
import '../data/json_strings_marathon.dart';
import '../data/json_strings_halfmarathon.dart';
import '../data/json_strings_10km.dart';
import 'activity_screen.dart';

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

class _DetailsScreenState extends State<DetailsScreen> {
  var _displayBanner = true;
  Stream<List> workouts;

  @override
// void initState (){
//   workouts = fetchWorkouts(workout);
//   super.initState();
// }

  @override
  Widget build(BuildContext context) {
    String className;
    if (widget.workout[0].startsWith('m')) {
      className = 'Marathon';
    } else if (widget.workout[0].startsWith('h')) {
      className = 'Halfmarathon';
    } else {
      className = '10km';
    }

    String jsonStrings = 'Json' + className + '.' + widget.workout;

    // final dynamic parsedJson = jsonDecode('$jsonStrings');
    final dynamic parsedJson = jsonDecode(JsonMarathon.marathon330);

    final dynamic deserializedObjects =
        parsedJson.map((o) => WorkoutObjectComplex.fromJson(o));

    final dynamic listOfObjects = deserializedObjects.toList();

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
          Text(widget.premarathon != null
              ? widget.premarathon + '\n' + widget.pre10km
              : widget.pre10km),
          Text(widget.frequency != null ? widget.frequency : ''),
        ],
      ),
      actions: [
        FlatButton(
          child: Text('Start'),
          onPressed: () {
            Navigator.pop(context);
            // Navigator.popAndPushNamed(context, '/schedule');
// https://stackoverflow.com/questions/55716230/how-to-do-nested-navigation-in-flutter
          },
        ),
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              child: banner,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _WorkoutList(index,
                    listOfObjects: listOfObjects, widget: widget);
              },
              childCount: listOfObjects == null ? 0 : listOfObjects.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkoutList extends StatelessWidget {
  const _WorkoutList(
    this.index, {
    Key key,
    @required this.listOfObjects,
    @required this.widget,
  }) : super(key: key);

  final int index;
  final listOfObjects;
  final DetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    // repository: LocalStorageRepository()
    return Container(
      color: new Color(0xFFFAFAFA),
      child: Column(
        children: [
          if (!listOfObjects[index].complete &&
              listOfObjects[index].workout == widget.workout)
            ComplexObjectView(listOfObjects[index]),
        ],
      ),
    );
  }
}
