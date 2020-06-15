import 'package:flutter/material.dart';
import 'pages/history_page.dart';
import 'pages/schedule_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final List<Tab> myTabs = [
    Tab(text: 'Schedule'),
    Tab(text: 'History'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Marathon in 3:30 Std'),
          centerTitle: true,
          bottom: TabBar(
            tabs: myTabs,
          ),
        ),
        body: TabBarView(
          children: [
            SchedulePage(),
            HistoryPage(),
          ],
        ),
      ),
    );
  }
}
