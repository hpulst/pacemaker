import 'package:flutter/material.dart';

import 'activity_screen.dart';
import 'explore_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          for (final tabItem in TabNavigationItem.items) tabItem.page,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) => setState(() => _selectedIndex = index),
        items: <BottomNavigationBarItem>[
          for (final tabItem in TabNavigationItem.items)
            BottomNavigationBarItem(
              icon: tabItem.icon,
              title: tabItem.title,
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

class TabNavigationItem {
  final Widget page;
  final Widget title;
  final Icon icon;

  TabNavigationItem({
    @required this.page,
    @required this.title,
    @required this.icon,
  });

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: ActivityScreen(),
          title: Text('Activity'),
          icon: Icon(Icons.dehaze),
        ),
        TabNavigationItem(
          page: ExploreScreen(),
          title: Text('Explore'),
          icon: Icon(Icons.search),
        ),
      ];
}
