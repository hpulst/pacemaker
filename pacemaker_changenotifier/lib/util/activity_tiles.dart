import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/workout_list_model.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'package:pacemaker_changenotifier/util/thumbnail.dart';
import 'package:provider/provider.dart';

class ActivityTile extends StatelessWidget {
  const ActivityTile(
      {this.complexObject, this.isExplore, this.animation, this.onComplete});

  @required
  final Workout complexObject;
  @required
  final bool isExplore;
  final Animation animation;
  final void Function() onComplete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFAFAFA),
      ),
      child: SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: CustomListTile(
          thumbnail: Container(
            decoration: BoxDecoration(
              color: buildColor(complexObject.intensity),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          isExplore: isExplore,
          id: complexObject.id,
          week: complexObject.week,
          weekday: complexObject.weekday,
          km: complexObject.km,
          time: complexObject.time,
          pace: complexObject.pace,
          intensity: complexObject.intensity,
          heartrate: complexObject.heartrate,
          complete: complexObject.complete,
          checkbox: RoundedCheckbox(
              complexObject: complexObject, onComplete: onComplete),
        ),
      ),
    );
  }
}

class RoundedCheckbox extends StatelessWidget {
  const RoundedCheckbox({
    Key key,
    @required this.complexObject,
    // @required
    this.onComplete,
  }) : super(key: key);

  final Workout complexObject;
  final void Function() onComplete;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      key: Key('WorkoutItem__${complexObject.id}__Checkbox'),
      value: complexObject.complete,
      onChanged: (complete) {
        final model = context.read<WorkoutListModel>();
        final workout =
            model.workoutById(complexObject.id).copy(complete: complete);
        model.updateWorkout(
          workout,
        );
        if (onComplete != null) {
          onComplete();
        }
      },
    );
  }
}

class CustomListTile extends StatefulWidget {
  const CustomListTile({
    this.thumbnail,
    this.isExplore,
    this.index,
    this.id,
    this.week,
    this.weekday,
    this.km,
    this.time,
    this.pace,
    this.intensity,
    this.heartrate,
    this.complete,
    this.checkbox,
  });

  final Widget thumbnail;
  final bool isExplore;
  final int index;
  final String id;
  final String week;
  final String weekday;
  final String km;
  final String time;
  final String pace;
  final String intensity;
  final String heartrate;
  final bool complete;
  final Widget checkbox;

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
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
                  widget.checkbox,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// removeObject(workout) {}

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
                  pace != '' && pace != null
                      ? time != '' && time != null
                          ? time + ' in ' + pace
                          : pace
                      : '',
                  style: const TextStyle(fontSize: 11),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 2.0),
                ),
                Text(
                  intensity != '' && intensity != null
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
                Text(
                  weekday + ' - ' + week,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 3.0),
                ),
                Text(
                  km,
                  style: const TextStyle(fontSize: 11),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  pace != '' && pace != null
                      ? time != '' && time != null
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
