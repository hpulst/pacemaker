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

  void initState() {
    WorkoutTable();
  }

  @override
  Widget build(BuildContext context) {
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
          MakeListTile('Di.', 'Ruhetag', '', ''),
          MakeListTile('Mi.', '13km', '59:30 min  4:35 min/km', '85-90%'),
          MakeListTile('Do.', '15km', '1:25 Std   5:40 min/km', '75-80%'),
          MakeListTile('Fr.', 'Ruhetag', '', ''),
          MakeListTile('Sa.', '3 x 2 km in 8:10 min Trabpause 5 min',
              '5:10 min/km', '90-95%'),
          MakeListTile('So.', '15km', '1:18 Std   5:20 min/km', '75-80%'),
          MakeListTile('Mo.', '15km', '1:18 Std   5:10 min/km', '75-80%'),
          MakeListTile('Di.', '15km', '1:18 Std   5:10 min/km', '75-80%'),
          MakeListTile('Mi.', '15km', '1:18 Std   5:10 min/km', '75-80%'),
          MakeListTile('Do.', '15km', '1:18 Std   5:10 min/km', '75-80%'),
          MakeListTile('Fr.', '15km', '1:18 Std   5:10 min/km', '75-80%'),
          MakeListTile('Sa.', '15km', '1:18 Std   5:10 min/km', '75-80%'),
          MakeListTile('So.', '15km', '1:18 Std   5:10 min/km', '75-80%'),
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
