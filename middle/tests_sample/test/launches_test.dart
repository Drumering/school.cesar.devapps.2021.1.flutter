// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tests_sample/models/launch.dart';
import 'package:tests_sample/models/launches_response.dart';
import 'package:tests_sample/source/launches_remote_datasource.dart';

import './launches_test.mocks.dart' as mock_client;

@GenerateMocks([Client])
void main() {
  test("When response success, then launches response is returned", () async {
    final client = mock_client.MockClient();

    final source = LaunchesRemoteDataSource(client);

    when(client.get(source.api)).thenAnswer((_) async => Response(
        '[{"launch_year": "2000", "success": false}, {"launch_year": "2001", "success": true}]',
        200));

    LaunchesResponse response = await source.getLaunches();

    expect(response, isA<LaunchesResponse>());
  });

  test("When response success, then successfully launches is returned",
      () async {
    final client = mock_client.MockClient();

    final source = LaunchesRemoteDataSource(client);

    when(client.get(source.api)).thenAnswer((_) async => Response(
        '[{"launch_year": "2000", "success": false}, {"launch_year": "2001", "success": true}]',
        200));

    LaunchesResponse response = await source.getLaunches(
      success: true,
    );

    final expectedResponse = LaunchesResponse([
      Launch(
        launchYear: "2001",
        success: true,
      ),
    ]);

    expect(response == expectedResponse, true);
  });
}
