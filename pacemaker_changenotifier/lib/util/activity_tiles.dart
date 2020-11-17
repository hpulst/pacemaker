import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/workout_list_model.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'package:pacemaker_changenotifier/util/thumbnail.dart';
import 'package:provider/provider.dart';

class ActivityTile extends StatelessWidget {
  const ActivityTile({this.complexObject, this.isExplore});

  final Workout complexObject;
  final bool isExplore;

  @override
  Widget build(BuildContext context) {
    final localTheme = Theme.of(context).textTheme;
    if (complexObject == null) {
      return Text('Choose your workout', style: localTheme.bodyText2);
    }
    return Container(
      decoration: const BoxDecoration(
        // border: Border(
        //   top: BorderSide(style: BorderStyle.solid, color: Colors.black12),
        // ),
        color: Color(0xFFFAFAFA),
      ),
      child: CustomListTile(
        thumbnail: Container(
          decoration: BoxDecoration(
            color: buildColor(complexObject.intensity),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        id: complexObject.id,
        isExplore: isExplore,
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

class CustomListTile extends StatefulWidget {
  const CustomListTile({
    this.thumbnail,
    this.isExplore,
    this.id,
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
  final bool isExplore;
  final String id;
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
  // bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: SizedBox(
        height: widget.isExplore ? 60.0 : 80.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
            ),
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
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 2.0, 0.0),
                      child: _Description(
                        isExplore: widget.isExplore,
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Row(
                children: <Widget>[
                  Checkbox(
                    key: Key('WorkoutItem__${widget.id}__Checkbox'),
                    value: widget.complete,
                    onChanged: (complete) {
                      final model = context.read<WorkoutListModel>();
                      final workout = model.workoutById(widget.id);
                      model.updateWorkout(
                        workout.copy(complete: complete),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    Key key,
    this.isExplore,
    this.week,
    this.weekday,
    this.km,
    this.time,
    this.pace,
    this.intensity,
    this.heartrate,
    this.complete,
  }) : super(key: key);

  final bool isExplore;
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
    if (!isExplore) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    weekday + ' - ' + week,
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    km,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                ),
                Text(
                  pace != null
                      ? time != null
                          ? time + ' in ' + pace
                          : pace
                      : '',
                  style: const TextStyle(fontSize: 11),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 2.0),
                ),
                Text(
                  intensity != null
                      ? intensity + ' mit max Herzfrequenz ' + heartrate
                      : '',
                  style: const TextStyle(fontSize: 11.0),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(weekday + ' - ' + week,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                const Padding(
                  padding: EdgeInsets.only(bottom: 3.0),
                ),
                Text(
                  km,
                  style: const TextStyle(fontSize: 11),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  pace != null
                      ? time != null
                          ? time + ' in ' + pace
                          : pace
                      : '',
                  style: const TextStyle(fontSize: 11),
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
                // Text(
                //   intensity != null ? intensity + ' with ' + heartrate : '',
                //   style: const TextStyle(fontSize: 8.0),
                // ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
