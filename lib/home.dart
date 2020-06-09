import 'package:Pacemaker/services/db.dart';
import 'package:flutter/material.dart';
import 'package:Pacemaker/model/workout_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  String _task;
  List<Workout> _tasks = [];
  List<Widget> get _items => _tasks.map((item) => format(item)).toList();

  final List<Tab> myTabs = [
    Tab(text: 'Schedule'),
    Tab(text: 'History'),
  ];

  Widget format(Workout item) {
    return Card(
      child: ListTile(
        // leading: Text(
        //   weekDay,
        //   style: TextStyle(fontSize: 20.0),
        // ),
        title: Text(item.weekday),
        // subtitle: Text(time),
        // trailing: Text(heartRate),
      ),
    );
  }

  void _toggle(Workout item) async {
    item.complete = !item.complete;
    dynamic result = await DB.update(Workout.table, item);
    print(result);
    refresh();
  }

  void _delete(Workout item) async {
    DB.delete(Workout.table, item);
    refresh();
  }

  void _save() async {
    Navigator.of(context).pop();
    Workout item = Workout(weekday: _task, complete: false);

    await DB.insert(Workout.table, item);
    setState(() => _task = '');
    refresh();
  }

  // void _create(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text("Create New Task"),
  //           actions: <Widget>[
  //             FlatButton(
  //                 child: Text('Cancel'),
  //                 onPressed: () => Navigator.of(context).pop()),
  //             FlatButton(child: Text('Save'), onPressed: () => _save())
  //           ],
  //           content: TextField(
  //             autofocus: true,
  //             decoration: InputDecoration(
  //                 labelText: 'Task Name', hintText: 'e.g. pick up bread'),
  //             onChanged: (value) {
  //               _task = value;
  //             },
  //           ),
  //         );
  //       });
  // }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() async {
    List<Map<String, dynamic>> _results = await DB.query(Workout.table);
    _tasks = _results.map((item) => Workout.fromMap(item)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Marathon in 3:15 Std'),
          centerTitle: true,
          bottom: TabBar(
            tabs: myTabs,
          ),
        ),
        body: Center(child: ListView(children: _items)),
        // ListView(children: [MakeListTile('Mo.', '15km', '1:18 Std   5:10 min/km', '75-80%')       ]),
      ),
    );
  }
}
