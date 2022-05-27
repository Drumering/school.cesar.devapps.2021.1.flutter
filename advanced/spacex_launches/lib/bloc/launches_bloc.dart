import 'dart:async';
import 'dart:convert';

import 'package:spacex_launches/abstracts/launches_interface.dart';
import 'package:spacex_launches/models/launch.dart';
import 'package:spacex_launches/repository/launches_repository.dart';

class LaunchesBloc {
  final LaunchesInterface datasource;
  late LaunchesRepository repository;

  LaunchesBloc(this.datasource) {
    repository = LaunchesRepository(datasource);
    _launchesController.add(_launches);
  }

  final _launchesController =
      StreamController<Future<List<Launch>>>.broadcast();

  Future<List<Launch>> get _launches async {
    return await repository.getLaunches();
  }

  Stream<Future<List<Launch>>> get launchesStream => _launchesController.stream;

  static List<Launch> parseLaunches(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Launch>((json) => Launch.fromJson(json)).toList();
  }

  Future<List<Launch>> getLaunches() async {
    _launchesController.sink.add(_launches);
    return await _launches;
  }

  void dispose() {
    _launchesController.close();
  }
}
