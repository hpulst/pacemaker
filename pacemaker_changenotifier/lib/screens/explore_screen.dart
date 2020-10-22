import 'package:flutter/material.dart';
import '../models/explore_model.dart'
    show WorkoutTable, WorkoutTableList, loadWorkouts;
import '../util/explore_tiles.dart' show SimpleObjectView;

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
  final String filename;

  ExploreTab(this.filename);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<WorkoutTable>>(
        future: loadWorkouts(filename),
        builder: (context, AsyncSnapshot<List<WorkoutTable>> snapshot) {
          if (snapshot.hasData) {
            return SimpleObjectView(simpleObjects: snapshot.data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        });
  }
}
