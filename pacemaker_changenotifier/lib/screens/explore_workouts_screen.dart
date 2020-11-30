import 'package:flutter/material.dart';

import 'package:pacemaker_changenotifier/models/explore_model.dart';
import 'package:pacemaker_changenotifier/models/navigator_model.dart';
import 'package:pacemaker_changenotifier/models/workout_list_model.dart';
import 'package:pacemaker_changenotifier/models/workout_model.dart';
import 'package:pacemaker_changenotifier/util/activity_tiles.dart';
import 'package:pacemaker_changenotifier/util/explore_tiles.dart';
import 'package:pacemaker_changenotifier/util/thumbnail.dart';
import 'package:pacemaker_changenotifier/util/workout_list_view.dart';
import 'package:provider/provider.dart';

class ExploreWorkouts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    final banner = MaterialBanner(
      backgroundColor: const Color(0xFFFAFAFA),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Voraussetzung:\n',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
          Text(args.premarathon != null
              ? args.premarathon + '\n' + args.pre10km
              : args.pre10km),
          Text(args.frequency ?? ''),
        ],
      ),
      actions: [
        _AddWorkouts(workoutTable: args.workoutTable),
        FlatButton(
          onPressed: () {},
          child: const Text(
            'Reset',
          ),
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(args.name),
        centerTitle: true,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Container(
                child: banner,
              ),
            ),
          ];
        },
        body: FutureWorkouts(args: args),
      ),
    );
  }
}

class FutureWorkouts extends StatefulWidget {
  const FutureWorkouts({
    Key key,
    @required this.args,
  }) : super(key: key);

  final ScreenArguments args;
  @override
  _FutureWorkoutsState createState() => _FutureWorkoutsState();
}

class _FutureWorkoutsState extends State<FutureWorkouts> {
  Future<List<Workout>> _workoutList;

  @override
  void initState() {
    super.initState();
    _workoutList = Provider.of<WorkoutListModel>(context, listen: false)
        ?.addWorkouts(widget.args.workout);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _workoutList,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                child: CircularProgressIndicator(),
                height: 30.0,
                width: 30.0,
              ),
            ],
          );
        }
        return WorkoutListView(filename: widget.args.workout, isExplore: true);
      },
    );
  }
}

class _AddWorkouts extends StatelessWidget {
  const _AddWorkouts({
    this.workoutTable,
    Key key,
  }) : super(key: key);

  final WorkoutTable workoutTable;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: const Text('Start'),
      onPressed: () {
        context.read<WorkoutListModel>().setWorkout(workoutTable);
        context.read<NavigatorModel>().currentIndex = 0;
        Navigator.pop(context);
      },
    );
  }
}

// class _WorkoutListView extends StatelessWidget {
//   const _WorkoutListView({this.filename, this.complete, this.isExplore});
//   final String filename;
//   final bool complete;
//   final bool isExplore;

//   @override
//   Widget build(BuildContext context) {
//     return Selector<WorkoutListModel, List<Workout>>(
//       selector: (_, model) => model.filterWorkouts(filename),
//       builder: (context, workouts, _) {
//         return ListView.builder(
//             itemCount: workouts.length,
//             itemBuilder: (context, index) {
//               final workout = workouts[index];
//               return Column(
//                 children: [
//                   ActivityTile(
//                     complexObject: workout,
//                     isExplore: isExplore,
//                     onComplete: () {},
//                   ),
//                 ],
//               );
//             }
//             // },
//             );
//       },
//     );
//   }
// }

// class _ActivityTile extends StatelessWidget {
//   const _ActivityTile({this.complexObject, this.isExplore});

//   final Workout complexObject;
//   final bool isExplore;

//   @override
//   Widget build(BuildContext context) {
//     final localTheme = Theme.of(context).textTheme;
//     if (complexObject == null) {
//       return Text('Choose your workout', style: localTheme.bodyText2);
//     }
//     return Container(
//       decoration: const BoxDecoration(
//         // border: Border(
//         //   top: BorderSide(style: BorderStyle.solid, color: Colors.black12),
//         // ),
//         color: Color(0xFFFAFAFA),
//       ),
//       child: CustomListTile(
//         thumbnail: Container(
//           decoration: BoxDecoration(
//             color: buildColor(complexObject.intensity),
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//         ),
//         id: complexObject.id,
//         isExplore: isExplore,
//         week: complexObject.week,
//         weekday: complexObject.weekday,
//         km: complexObject.km,
//         time: complexObject.time,
//         pace: complexObject.pace,
//         intensity: complexObject.intensity,
//         heartrate: complexObject.heartrate,
//         complete: complexObject.complete,
//       ),
//     );
//   }
// }

// class CustomListTile extends StatefulWidget {
//   const CustomListTile({
//     this.thumbnail,
//     this.isExplore,
//     this.id,
//     this.week,
//     this.weekday,
//     this.km,
//     this.time,
//     this.pace,
//     this.intensity,
//     this.heartrate,
//     this.complete,
//   });

//   final Widget thumbnail;
//   final bool isExplore;
//   final String id;
//   final String week;
//   final String weekday;
//   final String km;
//   final String time;
//   final String pace;
//   final String intensity;
//   final String heartrate;
//   final bool complete;

//   @override
//   _CustomListTileState createState() => _CustomListTileState();
// }

// class _CustomListTileState extends State<CustomListTile> {
//   // bool _isSelected = false;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 15.0),
//       child: SizedBox(
//         height: widget.isExplore ? 60.0 : 80.0,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Padding(
//               padding: EdgeInsets.only(left: 10.0),
//             ),
//             AspectRatio(
//               aspectRatio: 1,
//               child: widget.thumbnail,
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(10.0, 0.0, 2.0, 0.0),
//                       child: _Description(
//                         isExplore: widget.isExplore,
//                         week: widget.week,
//                         weekday: widget.weekday,
//                         km: widget.km,
//                         time: widget.time,
//                         pace: widget.pace,
//                         intensity: widget.intensity,
//                         heartrate: widget.heartrate,
//                         complete: widget.complete,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//               child: Row(
//                 children: <Widget>[
//                   Checkbox(
//                     key: Key('WorkoutItem__${widget.id}__Checkbox'),
//                     value: widget.complete,
//                     onChanged: (complete) {
//                       final model = context.read<WorkoutListModel>();
//                       final workout = model.workoutById(widget.id);
//                       model.updateWorkout(
//                         workout.copy(complete: complete),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _Description extends StatelessWidget {
//   const _Description({
//     Key key,
//     this.isExplore,
//     this.week,
//     this.weekday,
//     this.km,
//     this.time,
//     this.pace,
//     this.intensity,
//     this.heartrate,
//     this.complete,
//   }) : super(key: key);

//   final bool isExplore;
//   final String week;
//   final String weekday;
//   final String km;
//   final String time;
//   final String pace;
//   final String intensity;
//   final String heartrate;
//   final bool complete;

//   @override
//   Widget build(BuildContext context) {
//     if (!isExplore) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 4,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Text(
//                     weekday + ' - ' + week,
//                     style: const TextStyle(
//                       fontSize: 11,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(
//                     km,
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(bottom: 10),
//                 ),
//                 Text(
//                   pace != null
//                       ? time != null
//                           ? time + ' in ' + pace
//                           : pace
//                       : '',
//                   style: const TextStyle(fontSize: 11),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(bottom: 2.0),
//                 ),
//                 Text(
//                   intensity != null
//                       ? intensity + ' mit max Herzfrequenz ' + heartrate
//                       : '',
//                   style: const TextStyle(fontSize: 11.0),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       );
//     } else {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 4,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(weekday + ' - ' + week,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                     )),
//                 const Padding(
//                   padding: EdgeInsets.only(bottom: 3.0),
//                 ),
//                 Text(
//                   km,
//                   style: const TextStyle(fontSize: 11),
//                   overflow: TextOverflow.clip,
//                 ),
//                 Text(
//                   pace != null
//                       ? time != null
//                           ? time + ' in ' + pace
//                           : pace
//                       : '',
//                   style: const TextStyle(fontSize: 11),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 // Text(
//                 //   intensity != null ? intensity + ' with ' + heartrate : '',
//                 //   style: const TextStyle(fontSize: 8.0),
//                 // ),
//               ],
//             ),
//           ),
//         ],
//       );
//     }
//   }
// }
