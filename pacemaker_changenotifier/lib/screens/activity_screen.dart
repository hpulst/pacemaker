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
    final title = context.watch<WorkoutListModel>().selected ?? 'Workout';
    final workoutName = context.watch<WorkoutListModel>().selected;
    print(workoutName);

    final myTabs = <Tab>[
      const Tab(text: 'Schedule'),
      const Tab(text: 'History'),
    ];

    if (title == 'Workout') {
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: const Center(
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
              WorkoutListView(filename: workoutName, complete: false),
              WorkoutListView(filename: workoutName, complete: true),
            ],
          ),
        ),
      ),
    );
  }
}
