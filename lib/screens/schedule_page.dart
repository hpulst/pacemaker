import 'package:Pacemaker/widget/card_tile.dart';
import 'package:Pacemaker/services/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:Pacemaker/model/workout_model.dart';
import 'package:Pacemaker/data/data.dart';

class SchedulePage extends StatefulWidget {
  SchedulePage({Key key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String _task;
  List<Workout> _tasks = [];
  List<Widget> get _items =>
      _tasks.map<Widget>((item) => format(item)).toList();

  Widget format(Workout item) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Text(
              item.weekday + '\n' + item.week,
              style: TextStyle(fontSize: 20.0),
            ),
            title: Text(item.km + '    ' + item.pace),
            subtitle: Text(item.time + '    ' + item.heartrate),
            trailing: Icon(Icons.drag_handle),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                onChanged: (bool value) {
                  DBHelper.blockOrUnblock(item);
                  setState(() {
                    item.complete = value;
                    refresh();
                  });
                },
                value: item.complete,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _toggle(Workout item) async {
    item.complete = !item.complete;
    dynamic result = await DBHelper.update(Workout.table, item);

    print(result);
    refresh();
  }

  void _delete(Workout item) async {
    DBHelper.delete(Workout.table, item);
    refresh();
  }

  void _save() async {
    Navigator.of(context).pop();
    // Workout item = Workout(weekday: _task, complete: false);

    // await DB.insert(Workout.table, item);
    setState(() => _task = '');
    refresh();
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() async {
    ImportData.submit();

    List<Map<String, dynamic>> _results =
        await DBHelper.queryUncomplete(Workout.table);
    _tasks = _results.map((item) => Workout.fromMap(item)).toList();

    setState(() {});

    // _results.forEach(
    //   (element) {
    //     print(element);
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(children: _items),
    );
  }
}
