import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/navigator_model.dart';
import 'page/activity_screen.dart';
import 'page/explore_screen.dart';
import 'page/stats_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  int? currentTab;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NavigatorModel>();
    if (provider.currentIndex == 0) {}
    return Scaffold(
      body: IndexedStack(
        index: provider.currentIndex,
        children: [
          ActivityScreen(),
          StatsScreen(),
          ExploreScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.currentIndex,
        onTap: (int index) => provider.currentIndex = index,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dehaze,
            ),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.show_chart,
            ),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Entdecken',
          ),
        ],
        selectedItemColor: Colors.blueAccent,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        elevation: 4,
      ),
    );
  }
}
