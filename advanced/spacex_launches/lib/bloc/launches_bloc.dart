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

  List<Launch> launches = [];

  final _launchesController = StreamController<List<Launch>>.broadcast();

  Stream<List<Launch>> get launchesStream => _launchesController.stream;

  Future<List<Launch>> _launches() async {
    return await repository.getLaunches();
  }

  static List<Launch> parseLaunches(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Launch>((json) => Launch.fromJson(json)).toList();
  }

  onEvent({String? event, String? filter}) {
    switch (event) {
      case 'init':
        onInit();
        break;
      case 'refresh':
        onRefresh();
        break;
      case 'filter':
        onFilter(filter);
        break;
      default:
        print('Event $event not found');
    }
  }

  void onRefresh() {
    _launchesController.sink.add([]);
    _launches().then((launches) => _launchesController.sink.add(launches));
  }

  void onInit() {
    _launches().then((launches) => _launchesController.sink.add(launches));
    launchesStream.listen((event) {
      launches = event;
    });
  }

  onFilter(String? filter) {
    switch (filter) {
      case 'bySuccess':
        _launchesController.sink
            .add(launches.where((launch) => launch.launchSuccess).toList());
        break;
      case 'byYear':
        _launchesController.sink.add(
            launches.where((launch) => launch.launchYear == '2006').toList());
        break;
      default:
        _launchesController.sink.add(launches);
    }
  }

  void dispose() {
    _launchesController.close();
  }
}
