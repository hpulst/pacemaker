// import 'package:Pacemaker/layout/card_tile.dart';
// import 'package:Pacemaker/services/dbhelper.dart';
// import 'package:flutter/material.dart';
// import 'package:Pacemaker/model/workout_model.dart';

// class HistoryPage extends StatefulWidget {
//   HistoryPage({Key key}) : super(key: key);

//   @override
//   _HistoryPageState createState() => _HistoryPageState();
// }

// class _HistoryPageState extends State<HistoryPage> {
//   String _task;
//   List<Workout> _tasks = [];
//   List<Widget> get _items =>
//       _tasks.map<Widget>((item) => CardTile.format(item)).toList();

//   void _toggle(Workout item) async {
//     item.complete = !item.complete;
//     dynamic result = await DBHelper.update(Workout.table, item);
//     print(result);
//     refresh();
//   }

//   @override
//   void initState() {
//     refresh();
//     super.initState();
//   }

//   void refresh() async {
//     List<Map<String, dynamic>> _results =
//         await DBHelper.queryComplete(Workout.table);

//     _tasks = _results.map((item) => Workout.fromMap(item)).toList();

//     setState(() {});

//     _results.forEach((element) {
//       print(element);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ListView(children: _items),
//     );
//   }
// }
