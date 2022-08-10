import 'dart:async';
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:spacex_launches/bloc/launches/launch_events.dart';
import 'package:spacex_launches/bloc/launches/launch_state.dart';
import 'package:spacex_launches/models/launch.dart';

import '../../models/launches.dart';

class LaunchesBloc {
  final StreamController<LaunchEvent> _eventController =
      StreamController<LaunchEvent>();
  final StreamController<LaunchState> _stateController =
      StreamController<LaunchState>();

  Sink<LaunchEvent> get eventSink => _eventController.sink;
  Stream<LaunchState> get stateStream => _stateController.stream;

  LaunchesBloc() {
    _eventController.stream.listen(_mapEventToState);
  }

  _mapEventToState(LaunchEvent event) async {
    List<Launch> launches =
        Provider.of<Launches>(event.context, listen: false).launches;

    if (event is LoadLaunchesEvent) {
      Provider.of<Launches>(event.context, listen: false)
          .fetchLaunches()
          .then((_) => {
                launches = Provider.of<Launches>(event.context, listen: false)
                    .launches,
                _stateController.add(SuccessState(launches: launches)),
              });
    } else if (event is FilterLaunchesByYearEvent) {
      launches =
          launches.where((launch) => launch.launchYear == event.year).toList();
    } else if (event is FilterLaunchesBySuccessEvent) {
      if (event.success) {
        launches = launches.where((launch) => launch.launchSuccess).toList();
      }
    }

    _stateController.add(SuccessState(launches: launches));
  }

  static List<Launch> parseLaunches(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Launch>((json) => Launch.fromJson(json)).toList();
  }
}
