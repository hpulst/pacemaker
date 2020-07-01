import 'package:flutter/material.dart';
import 'screens/history_page.dart';
import 'screens/schedule_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Tab> myTabs = [
    Tab(text: 'Schedule'),
    Tab(text: 'History'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Marathon in 3:30 Std'),
          backgroundColor: Colors.white,
          centerTitle: true,
          bottom: TabBar(
            tabs: myTabs,
            indicatorColor: Colors.blueAccent,
            labelColor: Colors.blueAccent,
            unselectedLabelColor: Theme.of(context).accentColor,
          ),
        ),
        body: TabBarView(
          children: [
            SchedulePage(),
            HistoryPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dehaze),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Business'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blueAccent,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          elevation: 1,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
