import 'package:flutter/material.dart';

class ComplexObjectView extends StatelessWidget {
  ComplexObjectView(dynamic obj) : complexObject = obj;

  final dynamic complexObject;

  @override
  Widget build(BuildContext context) {
    final localTheme = Theme.of(context).textTheme;
    if (complexObject == null)
      return Text('Choose your workout', style: localTheme.bodyText2);

    return Container(
      decoration: new BoxDecoration(
        // border: new Border(
        //   top: new BorderSide(style: BorderStyle.solid, color: Colors.black26),
        // ),
        color: Colors.white,
        // color: new Color(0xFFFAFAFA),
      ),
      child: CustomListTile(
        thumbnail: Container(
          decoration: BoxDecoration(
            color: buildColor(complexObject.intensity),
          ),
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

  Color buildColor(String intensity) {
    switch (intensity) {
      case "":
        return Colors.primaries[12];
        break;
      case "SL":
        return Colors.primaries[11];
        break;
      case "LD":
        return Colors.primaries[10];
        break;
      case "MD":
        return Colors.primaries[9];
        break;
      case "SD":
        return Colors.primaries[1];
        break;
      case "TD":
        return Colors.primaries[0];
        break;
      case "SWL":
        return Colors.primaries[3];
        break;
      default:
        return Colors.primaries[17];
    }
  }
}

class CustomListTile extends StatefulWidget {
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
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: widget.thumbnail,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 2.0, 0.0),
                      child: _ArticleDescription(
                        week: widget.week,
                        weekday: widget.weekday,
                        km: widget.km,
                        time: widget.time,
                        pace: widget.pace,
                        intensity: widget.intensity,
                        heartrate: widget.heartrate,
                        complete: widget.complete,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: _LabeledCheckbox(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                value: _isSelected,
                onChanged: (bool newValue) {
                  setState(() {
                    _isSelected = newValue;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LabeledCheckbox extends StatelessWidget {
  const _LabeledCheckbox({
    this.padding,
    this.value,
    this.onChanged,
  });

  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: <Widget>[
          Checkbox(
            value: value,
            onChanged: (bool newValue) {
              onChanged(newValue);
            },
          ),
        ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(week + ' - ' + weekday,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              const Padding(
                padding: EdgeInsets.only(bottom: 3.0),
              ),
              Text(
                km,
                style: TextStyle(fontSize: 11),
              ),
              Text(
                pace != null ? time != null ? time + ' in ' + pace : pace : '',
                style: TextStyle(fontSize: 11),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                intensity != null ? intensity + ' with ' + heartrate : '',
                style: TextStyle(fontSize: 8.0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
