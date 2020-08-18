import 'package:Pacemaker/data/json_strings_10km.dart';
import 'package:Pacemaker/data/json_strings_halfmarathon.dart';
import 'package:Pacemaker/data/json_strings_marathon.dart';
import 'package:Pacemaker/tabs/explore_tabs.dart';
import 'package:Pacemaker/util/appbar_nested.dart';
import 'package:flutter/material.dart';

class Explore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String title = 'Workout plans';
    final List<Tab> myTabs = [
      Tab(text: 'Marathon'),
      Tab(text: 'Half marathon'),
      Tab(text: '10 km'),
    ];
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
            CustomSliverAppBar(myTabs: myTabs, title: title),
          ],
          body: TabBarView(
            children: [
              ExplorePage(JsonMarathon.listOfMarathons),
              ExplorePage(JsonHalfMarathon.listOfHalfmarathons),
              ExplorePage(JsonTenKilometres.listOfTenKilometres),
            ],
          ),
        ),
      ),
    );
  }
}
