import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/main.dart';
import 'package:provider/provider.dart';

import 'screens/activity_screen.dart';
import 'screens/explore_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final List<Widget> pages = <Widget>[
    ActivityScreen(),
    ExploreScreen(),
  ];
  int currentTab;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NavigatorModel>();

    return Scaffold(
      body: IndexedStack(
        index: provider.currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.currentIndex,
        onTap: (int index) => provider.currentIndex = index,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dehaze),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
        ],
        selectedItemColor: Colors.blueAccent,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        elevation: 1,
      ),
    );
  }
}
