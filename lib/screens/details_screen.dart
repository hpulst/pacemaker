import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/converted_object.dart';
import '../data/json_strings_marathon.dart';
import '../data/json_strings_halfmarathon.dart';
import '../data/json_strings_10km.dart';

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
  @override
  Widget build(BuildContext context) {
    String jsonStrings = 'JsonMarathon.' + widget.workout;
    final dynamic parsedJson = jsonDecode('$jsonStrings');
    final dynamic deserializedObjects =
        parsedJson.map((o) => WorkoutObjectComplex.fromJson(o));
    final dynamic listOfObjects = deserializedObjects.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Colors.white,
        centerTitle: true,
        flexibleSpace: Text(
            widget.pre10km != null ? 'Voraussetzung: ' + widget.pre10km : ''),
      ),
      body: Container(),
    );
  }
}
