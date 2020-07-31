import 'package:Pacemaker/tabs/workouts.dart';
import 'package:flutter/material.dart';

class Explore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Tab> myTabs = [
      Tab(text: 'Marathon'),
      Tab(text: 'Half marathon'),
      Tab(text: '10 km'),
    ];
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Workout plans'),
          backgroundColor: Colors.white,
          centerTitle: true,
          bottom: TabBar(
            tabs: myTabs,
            indicatorColor: Colors.blueAccent,
            labelColor: Colors.blueAccent,
            unselectedLabelColor: Theme.of(context).accentColor,
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              MarathonPage(),
              HalfmarathonPage(),
              TenKilometresPage(),
            ],
          ),
        ),
      ),
    );
  }
}
