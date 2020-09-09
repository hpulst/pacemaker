import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/explore_model.dart';
import 'package:pacemaker_changenotifier/util/explore_tiles.dart';

class ExploreTab extends StatelessWidget {
  ExploreTab(dynamic obj) : jsonStrings = obj;

  final dynamic jsonStrings;

  @override
  Widget build(BuildContext context) {
    final dynamic parsedJson = jsonDecode(jsonStrings);

    final dynamic deserializedObjects =
        parsedJson.map((o) => WorkoutObjectSimple.fromJson(o));

    final dynamic listOfObjects = deserializedObjects.toList();
    return SimpleObjectView(simpleObjects: listOfObjects);
  }
}
