import 'package:Pacemaker/model/model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:Pacemaker/data/data.dart';
import 'package:Pacemaker/model/model.dart';

class HomePage extends StatelessWidget {
  final List<Tab> myTabs = [
    Tab(text: 'Schedule'),
    Tab(text: 'History'),
  ];

  @override
  Widget build(BuildContext context) {
    WorkoutTable();
    print('workouttable calling');
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Marathon in 3:15 Std'),
          centerTitle: true,
          bottom: TabBar(
            tabs: myTabs,
          ),
        ),
        body: ListView(children: [
          MakeListTile('Mo.', '15km', '1:18 Std   5:10 min/km', '75-80%'),
        ]),
      ),
    );
  }
}

class MakeListTile extends StatelessWidget {
  MakeListTile(this.weekDay, this.distance, this.time, this.heartRate);

  final weekDay;
  final distance;
  final time;
  final heartRate;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text(
          weekDay,
          style: TextStyle(fontSize: 20.0),
        ),
        title: Text(distance),
        subtitle: Text(time),
        trailing: Text(heartRate),
      ),
    );
  }
}
