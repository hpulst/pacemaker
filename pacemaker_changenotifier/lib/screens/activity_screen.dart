import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/tabs/activity_history.dart';
import 'package:pacemaker_changenotifier/tabs/activity_schedule.dart';
import 'package:pacemaker_changenotifier/util/appbar_nested.dart';

class ActivityScreen extends StatelessWidget {
  // final int selectedTab;
  // ActivityScreen(this.selectedTab);

  @override
  Widget build(BuildContext context) {
    String title = 'Marathon in 3:30';
    final List<Tab> myTabs = [
      Tab(text: 'Schedule'),
      Tab(text: 'History'),
    ];
    return DefaultTabController(
      // initialIndex: selectedTab,
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
              ActivityScheduleTab(workout: 'marathon330'),
              ActivityHistoryTab(),
            ],
          ),
        ),
      ),
    );
  }
}
