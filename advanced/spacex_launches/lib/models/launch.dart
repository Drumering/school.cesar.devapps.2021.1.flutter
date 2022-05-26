class Launch {
  final String missionName;
  final String details;
  final DateTime launchDate;
  final String launchYear;
  final bool launchSuccess;

  Launch(
      {required this.missionName,
      required this.details,
      required this.launchDate,
      required this.launchYear,
      required this.launchSuccess});

  factory Launch.fromJson(Map<String, dynamic> json) {
    String details;
    bool launchSuccess;
    try {
      details = json['details'] as String;
      launchSuccess = json['launch_success'] as bool;
    } catch (e) {
      details = '';
      launchSuccess = false;
    }
    return Launch(
      missionName: json['mission_name'] as String,
      details: details,
      launchDate: DateTime.parse(json['launch_date_local'] as String),
      launchYear: json['launch_year'] as String,
      launchSuccess: launchSuccess,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'mission_name': missionName,
      'details': details,
      'launch_date_local': launchDate.toIso8601String(),
      'launch_year': launchYear,
      'launch_success': launchSuccess,
    };
  }
}
