import 'dart:convert';

import 'package:tests_sample/models/launch.dart';

class LaunchesResponse {
  List<Launch> launches;

  LaunchesResponse(this.launches);

  factory LaunchesResponse.fromJson(String rawJson) {
    return LaunchesResponse(
        List<Launch>.from(json.decode(rawJson).map((e) => Launch.fromJson(e))));
  }

  @override
  bool operator ==(Object other) {
    if (launches.length != (other as LaunchesResponse).launches.length) {
      return false;
    }
    for (var i = 0; i < launches.length; i++) {
      if (launches[i] != (other).launches[i]) {
        return false;
      }
    }
    return true;
  }
}
