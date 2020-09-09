import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/util/activity_tiles.dart';

class ActivityScheduleTab extends StatefulWidget {
  final String workout;

  ActivityScheduleTab({Key key, this.workout}) : super(key: key);

  @override
  _ActivityScheduleTabState createState() => _ActivityScheduleTabState();
}

class _ActivityScheduleTabState extends State<ActivityScheduleTab> {
  @override
  Widget build(BuildContext context) {
    final dynamic listOfObjects = 0;

    return ListView.builder(
      padding: EdgeInsets.zero,
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
