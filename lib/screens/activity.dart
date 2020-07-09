import 'package:Pacemaker/ui/history.dart';
import 'package:Pacemaker/ui/schedule.dart';
import 'package:flutter/material.dart';

class Activity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Tab> myTabs = [
      Tab(text: 'Schedule'),
      Tab(text: 'History'),
    ];
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Marathon in 3:30'),
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(Icons.clear_all),
                        SizedBox(width: 5.0),
                        Text('Mark all as done'),
                      ],
                    )),
                PopupMenuItem(
                    value: 2,
                    child: Row(
                      children: [
                        Icon(Icons.restore),
                        SizedBox(width: 5.0),
                        Text('Restart'),
                      ],
                    )),
              ],
              offset: Offset(0, 100),
            ),
          ],
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
      ),
    );
  }
}
