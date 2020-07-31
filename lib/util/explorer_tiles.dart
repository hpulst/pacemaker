import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class SimpleObjectViewList extends StatelessWidget {
  SimpleObjectViewList(List<dynamic> objects) : simpleObjects = objects;

  final List<dynamic> simpleObjects;

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];
    for (var i = 0; i < simpleObjects.length; i++) {
      widgets.addAll([
        SimpleObjectView(simpleObjects[i]),
      ]);
    }
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}

class SimpleObjectView extends StatelessWidget {
  SimpleObjectView(dynamic obj) : simpleObject = obj;

  final ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  final dynamic simpleObject;

  @override
  Widget build(BuildContext context) {
    final localTheme = Theme.of(context).textTheme;
    if (simpleObject == null) return Text('NULL', style: localTheme.bodyText2);

    return Container(
      decoration: new BoxDecoration(
        border: new Border(
          bottom:
              new BorderSide(style: BorderStyle.solid, color: Colors.black26),
        ),
        color: new Color(0xFFFAFAFA),
      ),
      child: OpenContainer(
          transitionType: _transitionType,
          openBuilder: (BuildContext _, VoidCallback openContainer) {
            return _DetailsPage();
          },
          tappable: false,
          closedShape: const RoundedRectangleBorder(),
          closedElevation: 0.0,
          closedBuilder: (BuildContext _, VoidCallback openContainer) {
            return ListTile(
              contentPadding: EdgeInsets.all(6.0),
              leading: Icon(Icons.brightness_1),
              title: Text(
                simpleObject.workout,
                style: TextStyle(fontSize: 15.0),
              ),
              onTap: openContainer,
            );
          }),
    );
  }
}

class _DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workout"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
    );
  }
}

// class CardTile {
//   static format(Workout item) {
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
//         ],
//       ),
//     );
//   }
// }
