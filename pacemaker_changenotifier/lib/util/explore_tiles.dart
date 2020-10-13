import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/screens/details_screen.dart';

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                      name: simpleObjects[index].name,
                      workout: simpleObjects[index].workout,
                      premarathon: simpleObjects[index].premarathon,
                      pre10km: simpleObjects[index].pre10km,
                      frequency: simpleObjects[index].frequency,
                    ),
                  ),
                );
              },
            ),
            decoration: new BoxDecoration(
              border: new Border(
                bottom: new BorderSide(
                    style: BorderStyle.solid, color: Colors.black26),
              ),
              color: new Color(0xFFFAFAFA),
            ),
          );
        },
      ),
    );
  }
}
