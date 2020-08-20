import 'dart:convert';
import 'package:Pacemaker/tabs/activity_schedule.dart';
import 'package:Pacemaker/util/activity_tiles.dart';
import 'package:flutter/material.dart';
import '../models/converted_object.dart';
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
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: listOfObjects == null ? 0 : listOfObjects.length,
        itemBuilder: (context, index) {
          if (index == 0 && _displayBanner) {
            return banner;
          }
          return Column(
            children: [
              if (!listOfObjects[index].complete &&
                  listOfObjects[index].workout == widget.workout)
                ComplexObjectView(listOfObjects[index]),
            ],
          );
        },
      ),
    );
  }
}
