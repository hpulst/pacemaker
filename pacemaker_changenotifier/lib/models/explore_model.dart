class WorkoutObjectSimple {
  const WorkoutObjectSimple({
    this.name,
    this.workout,
    this.premarathon,
    this.pre10km,
    this.frequency,
  });

  final String name;
  final String workout;
  final String premarathon;
  final String pre10km;
  final String frequency;

  factory WorkoutObjectSimple.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return WorkoutObjectSimple(
      name: json['name'] as String,
      workout: json['workout'] as String,
      premarathon: json['premarathon'] as String,
      pre10km: json['pre10km'] as String,
      frequency: json['frequency'] as String,
    );
  }
}
