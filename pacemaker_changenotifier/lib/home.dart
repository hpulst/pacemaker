import 'package:flutter/material.dart';

import 'screens/activity_screen.dart';
import 'screens/explore_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({this.firstTab, Key key}) : super(key: key);

  final int firstTab;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final List<Widget> pages = <Widget>[
    ActivityScreen(),
    ExploreScreen(),
  ];
  int currentTab;

  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    // final TabArguments args = ModalRoute.of(context).settings.arguments;

    // print(args.newTap);

    // if (args.newTap != null) {
    //   currentTab = args.newTap;
    // }

    currentTab ??= widget.firstTab;

    return Scaffold(
      body: PageStorage(
        child: pages[currentTab],
        bucket: _bucket,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        onTap: (int index) => setState(() => currentTab = index),
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
