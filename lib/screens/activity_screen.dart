import 'package:Pacemaker/tabs/activity_history.dart';
import 'package:Pacemaker/tabs/activity_schedule.dart';
import 'package:Pacemaker/util/appbar_nested.dart';
import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String title = 'Marathon in 3:30';
    final List<Tab> myTabs = [
      Tab(text: 'Schedule'),
      Tab(text: 'History'),
    ];
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            CustomSliverAppBar(myTabs: myTabs, title: title),
          ],
          body: TabBarView(
            children: [
              ScheduleTab(workout: 'marathon330'),
              HistoryTab(),
            ],
          ),
        ),
      ),
    );
  }
}
