class Launch {
  final String launchYear;
  final bool success;

  Launch({required this.launchYear, required this.success});

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      launchYear: json['launch_year'],
      success: json['success'],
    );
  }

  @override
  bool operator ==(Object other) {
    return other is Launch &&
        launchYear == other.launchYear &&
        success == other.success;
  }
}
