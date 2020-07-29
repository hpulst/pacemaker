import 'package:Pacemaker/models/workout_model.dart';
import 'package:flutter/material.dart';

class CardTile {
  static format(Workout item) {
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
        ],
      ),
    );
  }
}

class SimpleObjectViewList extends StatelessWidget {
  SimpleObjectViewList(List<dynamic> objects) : simpleObjects = objects;

  final List<dynamic> simpleObjects;

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];

    for (var i = 0; i < simpleObjects.length; i++) {
      widgets.addAll([
        // Text(
        //   'SimpleObject $i:',
        //   style: Theme.of(context).textTheme.subtitle1,
        // ),
        // const SizedBox(height: 10.0),
        SimpleObjectView(simpleObjects[i]),
        // const SizedBox(height: 1.0),
      ]);
    }

    // widgets.removeLast();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}

class SimpleObjectView extends StatelessWidget {
  SimpleObjectView(dynamic obj) : simpleObject = obj;

  final dynamic simpleObject;

  @override
  Widget build(BuildContext context) {
    final localTheme = Theme.of(context).textTheme;
    // final boldStyle =
    //     localTheme.bodyText2.copyWith(fontWeight: FontWeight.w600);

    if (simpleObject == null) return Text('NULL', style: localTheme.bodyText2);

    return Column(
      children: [
        Container(
          decoration: new BoxDecoration(
            border: new Border(
              bottom: new BorderSide(
                  style: BorderStyle.solid, color: Colors.black26),
            ),
            color: new Color(0xFFFAFAFA),
          ),
          child: ListTile(
              contentPadding: EdgeInsets.all(6.0),
              leading: Icon(Icons.brightness_1),
              title: Text(
                simpleObject.workout,
                style: TextStyle(fontSize: 15.0),
              ),
              onTap: () {
                print("hello");
              }),
        ),
      ],
    );
  }
}
