import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/workout_list_model.dart';
import 'package:pacemaker_changenotifier/util/appbar_nested.dart';
import 'package:pacemaker_changenotifier/util/workout_list_view.dart';
import 'package:provider/provider.dart';

class ActivityScreen extends StatelessWidget {
  // final int selectedTab;
  // ActivityScreen(this.selectedTab);

  @override
  Widget build(BuildContext context) {
    var title = context.watch<WorkoutListModel>().title ?? 'Workout';
    print(title);
    final myTabs = <Tab>[
      Tab(text: 'Schedule'),
      Tab(text: 'History'),
    ];

    if (title == 'Workout') {
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: Center(
          child: Text('Choose workout first'),
        ),
      );
    }

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
              WorkoutListView(filename: 'marathon315', complete: false),
              WorkoutListView(filename: 'marathon315', complete: true),
            ],
          ),
        ),
      ),
    );
  }
}
