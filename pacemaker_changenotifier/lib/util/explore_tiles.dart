import 'package:flutter/material.dart';

class SimpleObjectView extends StatelessWidget {
  final List<dynamic> simpleObjects;

  SimpleObjectView({Key key, @required this.simpleObjects}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: simpleObjects.length,
        itemBuilder: (context, index) {
          return Container(
            child: ListTile(
              contentPadding: EdgeInsets.all(6.0),
              leading: CircularProgressIndicator(
                strokeWidth: 3,
                value: 0.8,
              ),
              title: Text(
                simpleObjects[index].name,
                style: TextStyle(fontSize: 15.0),
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/workouts',
                  arguments: ScreenArguments(
                    name: simpleObjects[index].name,
                    workout: simpleObjects[index].workout,
                    premarathon: simpleObjects[index].premarathon,
                    pre10km: simpleObjects[index].pre10km,
                    frequency: simpleObjects[index].frequency,
                  ),
                );
              },
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(style: BorderStyle.solid, color: Colors.black26),
              ),
              color: Color(0xFFFAFAFA),
            ),
          );
        },
      ),
    );
  }
}

class ScreenArguments {
  final String name;
  final String workout;
  final String premarathon;
  final String pre10km;
  final String frequency;

  ScreenArguments(
      {Key key,
      this.name,
      this.workout,
      this.premarathon,
      this.pre10km,
      this.frequency});
}
