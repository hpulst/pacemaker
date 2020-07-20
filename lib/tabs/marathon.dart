import 'dart:convert';

import 'package:Pacemaker/data/json_strings_marathon.dart';
import 'package:Pacemaker/models/workout_object.dart';
import 'package:flutter/material.dart';

class MarathonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dynamic parsedJson = json.decode(JsonMarathon.marathon330);

    final dynamic deserializedObjects =
        parsedJson.map((dynamic o) => Workout.fromJson(o));

    final dynamic listOfObjects = deserializedObjects.toList();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        const SizedBox(height: 16.0),
        SimpleObjectViewList(listOfObjects),
        const SizedBox(height: 16.0),
      ],
    );
  }
}

class SimpleObjectViewList extends StatelessWidget {
  SimpleObjectViewList(List<dynamic> objects) : simpleObjects = objects;

  final List<dynamic> simpleObjects;

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];

    for (var i = 0; i < simpleObjects.length; i++) {
      widgets.addAll([
        Text(
          'SimpleObject $i:',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        const SizedBox(height: 4.0),
        SimpleObjectView(simpleObjects[i]),
        const SizedBox(height: 24.0),
      ]);
    }

    widgets.removeLast();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}

class SimpleObjectView extends StatelessWidget {
  SimpleObjectView(dynamic obj) : simpleObject = obj;

  final dynamic simpleObject;

  @override
  Widget build(BuildContext context) {
    final localTheme = Theme.of(context).textTheme;
    final boldStyle =
        localTheme.bodyText2.copyWith(fontWeight: FontWeight.w600);

    if (simpleObject == null) return Text('NULL', style: localTheme.bodyText2);

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Text(
              simpleObject.weekday,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      ),
    );
  }
}
