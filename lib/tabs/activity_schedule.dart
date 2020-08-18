import 'dart:convert';
import 'package:Pacemaker/util/activity_tiles.dart';
import 'package:flutter/material.dart';
import 'package:Pacemaker/data/json_strings_marathon.dart';
import 'package:Pacemaker/models/converted_object.dart';

class ScheduleTab extends StatefulWidget {
  final String workout;

  ScheduleTab({Key key, this.workout}) : super(key: key);

  @override
  _ScheduleTabState createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  @override
  Widget build(BuildContext context) {
    String jsonStrings = 'JsonMarathon.' + widget.workout;

    final dynamic parsedJson = jsonDecode(JsonMarathon.marathon330);

    final dynamic deserializedObjects =
        parsedJson.map((o) => WorkoutObjectComplex.fromJson(o));

    final dynamic listOfObjects = deserializedObjects.toList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: listOfObjects == null ? 0 : listOfObjects.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            if (!listOfObjects[index].complete &&
                listOfObjects[index].workout == "marathon330")
              ComplexObjectView(listOfObjects[index]),
          ],
        );
      },
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
