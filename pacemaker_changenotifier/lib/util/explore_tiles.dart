import 'package:flutter/material.dart';

class SimpleObjectView extends StatelessWidget {
  const SimpleObjectView({Key key, @required this.simpleObjects})
      : super(key: key);

  final List<dynamic> simpleObjects;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: simpleObjects.length,
        itemBuilder: (context, index) {
          return Container(
            child: ListTile(
              contentPadding: const EdgeInsets.all(6.0),
              leading: const CircularProgressIndicator(
                strokeWidth: 3,
                value: 0.8,
              ),
              title: Text(
                simpleObjects[index].name,
                style: const TextStyle(fontSize: 15.0),
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
            decoration: const BoxDecoration(
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
  ScreenArguments(
      {
      // Key key,
      this.name,
      this.workout,
      this.premarathon,
      this.pre10km,
      this.frequency});

  final String name;
  final String workout;
  final String premarathon;
  final String pre10km;
  final String frequency;
}
