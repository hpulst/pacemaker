import 'dart:math';
import 'package:flutter/material.dart';

class ComplexObjectViewList extends StatelessWidget {
  ComplexObjectViewList(List<dynamic> objects) : complexObjects = objects;

  final List<dynamic> complexObjects;

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];
    for (var i = 0; i < complexObjects.length; i++) {
      widgets.addAll([
        ComplexObjectView(complexObjects[i]),
      ]);
    }
    return Column(
      children: widgets,
    );
  }
}

class ComplexObjectView extends StatelessWidget {
  ComplexObjectView(dynamic obj) : complexObject = obj;

  final dynamic complexObject;

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final localTheme = Theme.of(context).textTheme;
    // if (complexObject == null) return Text('NULL', style: localTheme.bodyText2);

    return Container(
      decoration: new BoxDecoration(
        border: new Border(
          bottom:
              new BorderSide(style: BorderStyle.solid, color: Colors.black26),
        ),
        color: new Color(0xFFFAFAFA),
      ),
      child: CustomListTile(
        thumbnail: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(
            random.nextInt(256),
            random.nextInt(256),
            random.nextInt(256),
            1,
          )),
        ),
        week: complexObject.week,
        weekday: complexObject.weekday,
        km: complexObject.km,
        time: complexObject.time,
        pace: complexObject.pace,
        intensity: complexObject.intensity,
        heartrate: complexObject.heartrate,
        complete: complexObject.complete,
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  CustomListTile({
    Key key,
    this.thumbnail,
    this.week,
    this.weekday,
    this.km,
    this.time,
    this.pace,
    this.intensity,
    this.heartrate,
    this.complete,
  });

  final Widget thumbnail;
  final String week;
  final String weekday;
  final String km;
  final String time;
  final String pace;
  final String intensity;
  final String heartrate;
  final bool complete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 80,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: thumbnail,
            ),
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 2.0, 0.0),
                    child: _ArticleDescription(
                      week: week,
                      weekday: weekday,
                      km: km,
                      time: time,
                      pace: pace,
                      intensity: intensity,
                      heartrate: heartrate,
                      complete: complete,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ArticleDescription extends StatelessWidget {
  _ArticleDescription({
    Key key,
    this.week,
    this.weekday,
    this.km,
    this.time,
    this.pace,
    this.intensity,
    this.heartrate,
    this.complete,
  }) : super(key: key);

  final String week;
  final String weekday;
  final String km;
  final String time;
  final String pace;
  final String intensity;
  final String heartrate;
  final bool complete;

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
