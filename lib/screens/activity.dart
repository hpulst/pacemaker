import 'package:Pacemaker/tabs/history.dart';
import 'package:Pacemaker/tabs/schedule.dart';
import 'package:flutter/material.dart';

class Activity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _title = 'Marathon in 3:30';
    final List<Tab> myTabs = [
      Tab(text: 'Schedule'),
      Tab(text: 'History'),
    ];
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              _ActivityAppBar(myTabs: myTabs, title: _title),
            ];
          },
          body: TabBarView(
            children: [
              SchedulePage(),
              HistoryPage(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityAppBar extends StatelessWidget with PreferredSizeWidget {
  const _ActivityAppBar({
    Key key,
    @required this.myTabs,
    @required this.title,
  }) : super(key: key);

  final List<Tab> myTabs;
  final String title;
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(title),
      pinned: true,
      snap: true,
      floating: true,
      backgroundColor: Colors.white,
      centerTitle: true,
      forceElevated: true,
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
              ),
            ),
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
    );
  }
}
