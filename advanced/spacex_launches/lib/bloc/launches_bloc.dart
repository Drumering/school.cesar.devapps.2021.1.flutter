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
  }

  final _launchesController = StreamController<List<Launch>>.broadcast();

  Stream<List<Launch>> get launchesStream => _launchesController.stream;

  Future<List<Launch>> _launches() async {
    return await repository.getLaunches();
  }

  static List<Launch> parseLaunches(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Launch>((json) => Launch.fromJson(json)).toList();
  }

  onEvent(String event) {
    switch (event) {
      case 'init':
        _launches().then((launches) => _launchesController.sink.add(launches));
        break;
      case 'refresh':
        _launchesController.sink.add([]);
        _launches().then((launches) => _launchesController.sink.add(launches));
        break;
      case 'filter':
        onFilter();
        break;
      default:
        print('Event $event not found');
    }
  }

  onFilter() {
    List<Launch> filteredLaunches = [];
    // launchesStream.listen((launches) {
    //   filteredLaunches = launches
    //       .where((launch) =>
    //           launch.launchYear.toString().contains(repository.filter))
    //       .toList();
    //   _launchesController.sink.add(filteredLaunches);
    // });
    launchesStream.listen((launches) {
      filteredLaunches = launches
          .where((launch) => launch.missionName.toString() == 'FalconSat')
          .toList();
      _launchesController.sink.add(filteredLaunches);
    });
  }

  void dispose() {
    _launchesController.close();
  }
}
