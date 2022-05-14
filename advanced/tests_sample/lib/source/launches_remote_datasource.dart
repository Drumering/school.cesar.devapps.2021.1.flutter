import 'package:http/http.dart';
import 'package:tests_sample/models/launches_response.dart';

class LaunchesRemoteDataSource {
  final Client client;

  final Uri api = Uri.parse('https://api.spacexdata.com/v3/launches');

  LaunchesRemoteDataSource(this.client);

  Future<LaunchesResponse> getLaunches({String? year, bool? success}) async {
    final response = await client.get(api);

    late LaunchesResponse finalResponse;

    if (response.statusCode == 200) {
      finalResponse = LaunchesResponse.fromJson(response.body);
      if (year != null) {
        finalResponse.launches = finalResponse.launches
            .where((launch) => launch.launchYear == year)
            .toList();
      }

      if (success != null) {
        finalResponse.launches = finalResponse.launches
            .where((launch) => launch.success == success)
            .toList();
      }

      return finalResponse;
    } else {
      throw Exception('Failed to load launches');
    }
  }
}
