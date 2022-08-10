import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../datasource/http_launches_datasource.dart';
import '../repository/launches_repository.dart';
import 'launch.dart';

class Launches with ChangeNotifier {
  List<Launch> _launches = [];
  List<Launch> get launches => _launches;
  set launches(List<Launch> value) {
    _launches = value;
    notifyListeners();
  }

  Future<void> fetchLaunches() async {
    final repository = LaunchesRepository(HttpLaunchesDatasource());
    launches = await repository.getLaunches();
  }
}
