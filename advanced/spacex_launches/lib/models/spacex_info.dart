class SpaceXInfo {
  SpaceXInfo(
      {required this.name,
      required this.founder,
      required this.founded,
      required this.employees,
      required this.launchSites,
      required this.valuation});

  final String name;
  final String founder;
  final int founded;
  final int employees;
  final int launchSites;
  final int valuation;

  factory SpaceXInfo.fromJson(Map<String, dynamic> json) {
    return SpaceXInfo(
      name: json['name'] as String,
      founder: json['founder'] as String,
      founded: json['founded'] as int,
      employees: json['employees'] as int,
      launchSites: json['launch_sites'] as int,
      valuation: json['valuation'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'founder': founder,
      'founded': founded,
      'employees': employees,
      'launch_sites': launchSites,
      'valuation': valuation,
    };
  }
}
