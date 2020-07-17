import 'package:Pacemaker/services/dbhelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Pacemaker/models/workout_model.dart';

class SchedulePage extends StatefulWidget {
  SchedulePage({Key key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('marathon').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    print('Hi');
    return ListView(
      padding: EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Workout.fromSnapshot(data);
    print(data);
    print('Hello');

    return Padding(
      key: ValueKey(record.week),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.weekday),
        ),
      ),
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
