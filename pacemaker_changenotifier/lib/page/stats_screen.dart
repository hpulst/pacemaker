import 'package:flutter/material.dart';
import 'package:pacemaker_changenotifier/models/workout_list_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<WorkoutListModel>();

    final selectedTitle = model.selectedTitle;
    final numComplete = model.numCompleted;
    final numLength = model.numLength;
    final numPercent =
        (numComplete / numLength).isNaN ? 0.0 : numComplete / numLength;

    if (selectedTitle == 'Workout') {
      return Scaffold(
        appBar: AppBar(
          title: Text(selectedTitle),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('Choose workout first'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedTitle),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: CircularPercentIndicator(
                key: const Key('__circularPercentIndicator__'),
                radius: 180.0, //radius for circle
                lineWidth: 15.0, //width of circle line
                animation:
                    true, //animate when it shows progress indicator first
                percent:
                    numPercent, //vercentage value: 0.6 for 60% (60/100 = 0.6)
                center: Text(
                  '${(numPercent * 100).toStringAsFixed(0)} %',
                  style: const TextStyle(fontSize: 20.0),
                ), //center text, you can set Icon as well

                footer: Text(
                  'Completed $numComplete of $numLength',
                  style: const TextStyle(fontSize: 17.0),
                ), //footer text
                backgroundColor:
                    Colors.lightBlue[50], //backround of progress bar
                circularStrokeCap: CircularStrokeCap
                    .round, //corner shape of progress bar at start/end
                progressColor:
                    Theme.of(context).accentColor, //progress bar color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
