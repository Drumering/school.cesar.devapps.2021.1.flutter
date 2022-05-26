import 'package:spacex_launches/models/launch.dart';
import 'package:spacex_launches/models/spacex_info.dart';

abstract class LaunchesInterface {
  Future<List<Launch>> getLaunches();
  Future<SpaceXInfo> getInfo();
}
