import 'dart:convert';
import 'package:Pacemaker/util/activity_tiles.dart';
import 'package:flutter/material.dart';
import 'package:Pacemaker/data/json_strings_marathon.dart';
import 'package:Pacemaker/models/converted_object.dart';

class ActivityScheduleTab extends StatefulWidget {
  final String workout;

  ActivityScheduleTab({Key key, this.workout}) : super(key: key);

  @override
  _ActivityScheduleTabState createState() => _ActivityScheduleTabState();
}

class _ActivityScheduleTabState extends State<ActivityScheduleTab> {
  @override
  Widget build(BuildContext context) {
    String jsonStrings = 'JsonMarathon.' + widget.workout;

    final dynamic parsedJson = jsonDecode(JsonMarathon.marathon330);

    final dynamic deserializedObjects =
        parsedJson.map((o) => WorkoutObjectComplex.fromJson(o));

    final dynamic listOfObjects = deserializedObjects.toList();

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: listOfObjects == null ? 0 : listOfObjects.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            if (!listOfObjects[index].complete &&
                listOfObjects[index].workout == "marathon330")
              ComplexObjectView(listOfObjects[index]),
          ],
        );
      },
    );
  }
}
