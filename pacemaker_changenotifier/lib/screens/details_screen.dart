import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/util/activity_tiles.dart';
import 'package:pacemaker_changenotifier/util/workout_list_view.dart';

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
        body: WorkoutListView(),
      ),
    );
  }
}
