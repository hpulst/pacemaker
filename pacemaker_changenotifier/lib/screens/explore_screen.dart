import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/screens/about_screen.dart' as about;

import '../models/explore_model.dart';
import '../util/explore_tiles.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const title = 'Trainingspläne';
    const myTabs = <Tab>[
      Tab(text: 'Marathon'),
      Tab(text: 'Halbmarathon'),
      Tab(text: '10 km'),
    ];
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(title),
          centerTitle: true,
          bottom: const TabBar(
            tabs: myTabs,
            indicatorColor: Colors.blueAccent,
            labelColor: Colors.blueAccent,
            unselectedLabelColor: Colors.grey,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                about.showAboutDialog(context: context);
              },
            )
          ],
        ),
        body: const TabBarView(
          children: [
            ExploreTab('explore_marathon'),
            ExploreTab('explore_halfmarathon'),
            ExploreTab('explore_10km'),
          ],
        ),
      ),
    );
  }
}

class ExploreTab extends StatelessWidget {
  const ExploreTab(this.filename);

  final String filename;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<WorkoutTable>>(
        future: loadWorkouts(filename),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SimpleObjectView(simpleObjects: snapshot.data);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        });
  }
}
