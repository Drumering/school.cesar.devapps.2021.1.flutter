import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:spacex_launches/abstracts/launches_interface.dart';
import 'package:spacex_launches/bloc/launches/launch_bloc.dart';
import 'package:spacex_launches/models/spacex_info.dart';
import 'package:spacex_launches/models/launch.dart';
import 'package:http/http.dart' as http;

class HttpLaunchesDatasource implements LaunchesInterface {
  @override
  Future<SpaceXInfo> getInfo() async {
    final response =
        await http.get(Uri.parse('https://api.spacexdata.com/v3/info'));

    if (response.statusCode == 200) {
      return SpaceXInfo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load SpaceX info');
    }
  }

  @override
  Future<List<Launch>> getLaunches() async {
    final response =
        await http.get(Uri.parse('https://api.spacexdata.com/v3/launches'));

    if (response.statusCode == 200) {
      return compute(LaunchesBloc.parseLaunches, response.body);
    } else {
      throw Exception('Failed to load SpaceX launches');
    }
  }
}
