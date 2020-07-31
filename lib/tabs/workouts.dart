import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:Pacemaker/data/json_strings_10km.dart';
import 'package:Pacemaker/data/json_strings_marathon.dart';
import 'package:Pacemaker/data/json_strings_halfmarathon.dart';
import 'package:Pacemaker/models/converted_object.dart';
import 'package:Pacemaker/util/explorer_tiles.dart';

class MarathonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dynamic parsedJson = json.decode(JsonMarathon.listOfMarathons);

    final dynamic deserializedObjects =
        parsedJson.map((o) => WorkoutObjectSimple.fromJson(o));

    final dynamic listOfObjects = deserializedObjects.toList();
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        SimpleObjectViewList(listOfObjects),
      ],
    );
  }
}

class HalfmarathonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dynamic parsedJson =
        json.decode(JsonHalfMarathon.listOfHalfmarathons);

    final dynamic deserializedObjects =
        parsedJson.map((o) => WorkoutObjectSimple.fromJson(o));

    final dynamic listOfObjects = deserializedObjects.toList();
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        SimpleObjectViewList(listOfObjects),
      ],
    );
  }
}

class TenKilometresPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dynamic parsedJson =
        json.decode(JsonTenKilometres.listOfTenKilometres);

    final dynamic deserializedObjects =
        parsedJson.map((o) => WorkoutObjectSimple.fromJson(o));

    final dynamic listOfObjects = deserializedObjects.toList();
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        SimpleObjectViewList(listOfObjects),
      ],
    );
  }
}
