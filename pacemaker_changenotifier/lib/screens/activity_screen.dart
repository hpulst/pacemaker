import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/workout_list_model.dart';
import 'package:pacemaker_changenotifier/util/appbar_nested.dart';
import 'package:pacemaker_changenotifier/util/workout_list_view.dart';
import 'package:provider/provider.dart';

class ActivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<WorkoutListModel>();
    final selectedWorkout = model.selectedWorkout;
    final selectedTitle = model.selectedTitle;

    final myTabs = <Tab>[
      const Tab(text: 'Schedule'),
      const Tab(text: 'History'),
    ];

    if (selectedTitle == 'Workout') {
      return Scaffold(
        appBar: AppBar(
          title: Text(selectedTitle),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('Choose workout first'),
        ),
      );
    }

    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            CustomSliverAppBar(myTabs: myTabs, title: selectedTitle),
          ],
          body: TabBarView(
            children: [
              WorkoutListView(
                  filename: selectedWorkout, complete: false, isExplore: false),
              WorkoutListView(
                  filename: selectedWorkout, complete: true, isExplore: false),
            ],
          ),
        ),
      ),
    );
  }
}
