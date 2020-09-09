import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/data/json_strings_10km.dart';
import 'package:pacemaker_changenotifier/data/json_strings_halfmarathon.dart';
import 'package:pacemaker_changenotifier/data/json_strings_marathon.dart';
import 'package:pacemaker_changenotifier/tabs/explore_tabs.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String title = 'Trainingspläne';
    final List<Tab> myTabs = [
      Tab(text: 'Marathon'),
      Tab(text: 'Halbmarathon'),
      Tab(text: '10 km'),
    ];
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          bottom: TabBar(
            tabs: myTabs,
            indicatorColor: Colors.blueAccent,
            labelColor: Colors.blueAccent,
            unselectedLabelColor: Colors.grey,
          ),
        ),
        body: TabBarView(
          children: [
            ExploreTab(JsonMarathon.listeMarathon),
            ExploreTab(JsonHalbmarathon.listeHalbmarathon),
            ExploreTab(Json10km.listeZehnKilometer),
          ],
        ),
      ),
    );
  }
}
