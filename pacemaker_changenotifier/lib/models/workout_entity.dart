// class WorkoutEntity {
//   const WorkoutEntity({
//     this.id,
//     this.workout,
//     this.week,
//     this.weekday,
//     this.km,
//     this.time,
//     this.pace,
//     this.intensity,
//     this.heartrate,
//     this.complete,
//   });
// // class WorkoutEntity {
// //   const WorkoutEntity({
// //     // this.id,
// //     this.workout,
// //     this.week,
// //     this.weekday,
// //     this.km,
// //     this.time,
// //     this.pace,
// //     this.intensity,
// //     this.heartrate,
// //     this.complete,
// //   });

//   final String id;
//   final String workout;
//   final String week;
//   final String weekday;
//   final String km;
//   final String time;
//   final String pace;
//   final String intensity;
//   final String heartrate;
//   final bool complete;
// //   // final String id;
// //   final String workout;
// //   final String week;
// //   final String weekday;
// //   final String km;
// //   final String time;
// //   final String pace;
// //   final String intensity;
// //   final String heartrate;
// //   final bool complete;

//   static WorkoutEntity fromJson(Map<String, dynamic> json) {
//     if (json == null) return null;
// //   static WorkoutEntity fromJson(Map<String, dynamic> json) {
// //     if (json == null) return null;

//     return WorkoutEntity(
//       id: json['id'] as String,
//       workout: json['workout'] as String,
//       week: json['week'] as String,
//       weekday: json['weekday'] as String,
//       km: json['km'] as String,
//       time: json['time'] as String,
//       pace: json['pace'] as String,
//       intensity: json['intensity'] as String,
//       heartrate: json['heartrate'] as String,
//       complete: json['complete'] as bool,
//     );
//   }
// //     return WorkoutEntity(
// //       // id: json['id'] as String,
// //       workout: json['workout'] as String,
// //       week: json['week'] as String,
// //       weekday: json['weekday'] as String,
// //       km: json['km'] as String,
// //       time: json['time'] as String,
// //       pace: json['pace'] as String,
// //       intensity: json['intensity'] as String,
// //       heartrate: json['heartrate'] as String,
// //       complete: json['complete'] as bool,
// //     );
// //   }

//   Map<String, dynamic> toJson() {
//     return {};
//   }
// }
// //   Map<String, dynamic> toJson() {
// //     return {};
// //   }
// // }
