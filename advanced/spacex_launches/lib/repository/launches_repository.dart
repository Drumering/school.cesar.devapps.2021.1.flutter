import 'package:spacex_launches/abstracts/launches_interface.dart';
import 'package:spacex_launches/models/spacex_info.dart';
import 'package:spacex_launches/models/launch.dart';

class LaunchesRepository implements LaunchesInterface {
  final LaunchesInterface datasource;

  LaunchesRepository(this.datasource);

  @override
  Future<SpaceXInfo> getInfo() async {
    return await datasource.getInfo();
  }

  @override
  Future<List<Launch>> getLaunches() async {
    return await datasource.getLaunches();
  }
}
