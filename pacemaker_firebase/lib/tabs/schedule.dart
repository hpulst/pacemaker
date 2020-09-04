import 'dart:convert';
import 'package:Pacemaker/util/activity_tiles.dart';
import 'package:flutter/material.dart';
import 'package:Pacemaker/data/json_strings_marathon.dart';
import 'package:Pacemaker/models/converted_object.dart';

class SchedulePage extends StatefulWidget {
  SchedulePage({Key key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    final dynamic parsedJson = jsonDecode(JsonMarathon.marathon315);

    final dynamic deserializedObjects =
        parsedJson.map((o) => WorkoutObjectComplex.fromJson(o));

    final dynamic listOfObjects = deserializedObjects.toList();
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        ComplexObjectViewList(listOfObjects),
      ],
    );
  }
}

// Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
//   final item = Workout.fromSnapshot(data);
//   return Card(
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         ListTile(
//           leading: Text(
//             item.weekday + '\n' + item.week,
//             style: TextStyle(fontSize: 20.0),
//           ),
//           title: Text(item.km + '    ' + item.pace),
//           subtitle: Text(item.time + '    ' + item.heartrate),
//           trailing: Icon(Icons.drag_handle),
//         ),
//         ButtonBar(
//           alignment: MainAxisAlignment.start,
//           children: [
//             Checkbox(
//               onChanged: (bool value) {
//                 DBHelper.blockOrUnblock(item);
//                 setState(() {
//                   item.complete = value;
//                 });
//               },
//               value: item.complete,
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }
// }
