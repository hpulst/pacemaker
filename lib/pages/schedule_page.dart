// import 'package:Pacemaker/layout/card_tile.dart';
// import 'package:Pacemaker/services/dbhelper.dart';
// import 'package:flutter/material.dart';
// import 'package:Pacemaker/model/workout_model.dart';
// import 'package:Pacemaker/data/data.dart';

// class SchedulePage extends StatefulWidget {
//   SchedulePage({Key key}) : super(key: key);

//   @override
//   _SchedulePageState createState() => _SchedulePageState();
// }

// class _SchedulePageState extends State<SchedulePage> {
//   String _task;
//   List<Workout> _tasks = [];
//   List<Widget> get _items =>
//       _tasks.map<Widget>((item) => format(item)).toList();

//   Widget format(Workout item) {
//     return Card(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             leading: Text(
//               item.weekday + '\n' + item.week,
//               style: TextStyle(fontSize: 20.0),
//             ),
//             title: Text(item.km + '    ' + item.pace),
//             subtitle: Text(item.time + '    ' + item.heartrate),
//             trailing: Icon(Icons.drag_handle),
//           ),
//           ButtonBar(
//             alignment: MainAxisAlignment.start,
//             children: [
//               Checkbox(
//                 onChanged: (bool value) {
//                   DBHelper.blockOrUnblock(item);
//                   setState(() {
//                     item.complete = value;
//                     refresh();
//                   });
//                 },
//                 value: item.complete,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   void _toggle(Workout item) async {
//     item.complete = !item.complete;
//     dynamic result = await DBHelper.update(Workout.table, item);

//     print(result);
//     refresh();
//   }

//   void _delete(Workout item) async {
//     DBHelper.delete(Workout.table, item);
//     refresh();
//   }

//   void _save() async {
//     Navigator.of(context).pop();
//     // Workout item = Workout(weekday: _task, complete: false);

//     // await DB.insert(Workout.table, item);
//     setState(() => _task = '');
//     refresh();
//   }

//   @override
//   void initState() {
//     refresh();
//     super.initState();
//   }

//   void refresh() async {
//     ImportData.submit();

//     List<Map<String, dynamic>> _results =
//         await DBHelper.queryUncomplete(Workout.table);
//     _tasks = _results.map((item) => Workout.fromMap(item)).toList();

//     setState(() {});

//     // _results.forEach(
//     //   (element) {
//     //     print(element);
//     //   },
//     // );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ListView(children: _items),
//     );
//   }
// }

// import 'package:Pacemaker/tabs/history.dart';
// import 'package:Pacemaker/tabs/schedule.dart';
// import 'package:flutter/material.dart';

// class Activity extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final List<Tab> myTabs = [
//       Tab(text: 'Schedule'),
//       Tab(text: 'History'),
//     ];
//     return DefaultTabController(
//       length: myTabs.length,
//       child: Scaffold(
//         body: CustomScrollView(slivers: [
//           _ActivityAppBar(myTabs: myTabs),
//           TabBarView(
//             children: [
//               SchedulePage(),
//               HistoryPage(),
//             ],
//           ),
//         ]),
//       ),
//     );
//   }
// }

// class _ActivityAppBar extends StatelessWidget with PreferredSizeWidget {
//   const _ActivityAppBar({
//     Key key,
//     @required this.myTabs,
//   }) : super(key: key);

//   final List<Tab> myTabs;
//   @override
//   Size get preferredSize => Size.fromHeight(kToolbarHeight);

//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       title: Text('Marathon in 3:30'),
//       floating: true,
//       backgroundColor: Colors.white,
//       centerTitle: true,
//       actions: [
//         PopupMenuButton(
//           itemBuilder: (context) => [
//             PopupMenuItem(
//               value: 1,
//               child: Row(
//                 children: [
//                   Icon(Icons.clear_all),
//                   SizedBox(width: 5.0),
//                   Text('Mark all as done'),
//                 ],
//               ),
//             ),
//             PopupMenuItem(
//                 value: 2,
//                 child: Row(
//                   children: [
//                     Icon(Icons.restore),
//                     SizedBox(width: 5.0),
//                     Text('Restart'),
//                   ],
//                 )),
//           ],
//           offset: Offset(0, 100),
//         ),
//       ],
//       bottom: TabBar(
//         tabs: myTabs,
//         indicatorColor: Colors.blueAccent,
//         labelColor: Colors.blueAccent,
//         unselectedLabelColor: Theme.of(context).accentColor,
//       ),
//     );
//   }
// }
