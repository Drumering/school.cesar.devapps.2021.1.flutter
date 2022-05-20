class Launch {
  final String missionName;
  final String details;
  final DateTime launchDate;

  Launch({
    required this.missionName,
    required this.details,
    required this.launchDate,
  });

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      missionName: json['mission_name'] as String,
      details: json['details'] as String,
      launchDate: DateTime.parse(json['launch_date_local'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'mission_name': missionName,
      'details': details,
      'launch_date_local': launchDate.toIso8601String(),
    };
  }
}
