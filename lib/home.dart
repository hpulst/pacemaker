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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Text(
              item.weekday,
              style: TextStyle(fontSize: 20.0),
            ),
            title: Text(item.km + '    ' + item.pace),
            subtitle: Text(item.time),
            trailing: Text(item.heartrate),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  icon: Icon(Icons.check_circle),
                  color: Theme.of(context).accentColor,
                  onPressed: null),
              IconButton(
                  icon: Icon(Icons.cancel),
                  color: Theme.of(context).accentColor,
                  onPressed: null)
            ],
          ),
        ],
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

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() async {
    // _task = 'Montag';
    Workout item = Workout(
      // id: 0,
      weekday: 'So.',
      km: '15km',
      time: '1:18 Std',
      pace: '5:10 min/km',
      intensity: 'MD',
      heartrate: '75-80%',
      // complete: false,
    );

    await DB.insert(Workout.table, item);
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
          title: Text('Marathon in 3:30 Std'),
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
