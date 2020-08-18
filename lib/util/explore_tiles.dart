import 'package:flutter/material.dart';

class SimpleObjectView extends StatelessWidget {
  final List<dynamic> simpleObjects;

  SimpleObjectView({Key key, @required this.simpleObjects}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: simpleObjects.length,
        itemBuilder: (context, index) {
          return Container(
            child: ListTile(
              contentPadding: EdgeInsets.all(6.0),
              leading: Icon(Icons.brightness_1),
              title: Text(
                simpleObjects[index].name,
                style: TextStyle(fontSize: 15.0),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _DetailsPage(
                      workout: simpleObjects[index].workout,
                      premarathon: simpleObjects[index].premarathon,
                      pre10km: simpleObjects[index].pre10km,
                      frequency: simpleObjects[index].frequency,
                    ),
                  ),
                );
              },
            ),
            // decoration: new BoxDecoration(
            //   border: new Border(
            //     bottom: new BorderSide(
            //         style: BorderStyle.solid, color: Colors.black26),
            //   ),
            //   color: new Color(0xFFFAFAFA),
            // ),
          );
        },
      ),
    );
  }
}

class _DetailsPage extends StatelessWidget {
  _DetailsPage(
      {Key key, this.workout, this.premarathon, this.pre10km, this.frequency})
      : super(key: key);

  final String workout;
  final String premarathon;
  final String pre10km;
  final String frequency;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(workout),
        backgroundColor: Colors.white,
        centerTitle: true,
        flexibleSpace: Text(pre10km != null ? 'Voraussetzung: ' + pre10km : ''),
      ),
    );
  }
}
