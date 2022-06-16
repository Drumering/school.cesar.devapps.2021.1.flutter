// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:spacex_launches/abstracts/launches_interface.dart';

import 'package:spacex_launches/models/spacex_info.dart';
import 'package:spacex_launches/repository/launches_repository.dart';

import 'http_test.mocks.dart' as mocks;
import 'http_test.mocks.dart';

@GenerateMocks([LaunchesInterface, SpaceXInfo])
void main() {
  late MockLaunchesInterface? client;
  late LaunchesRepository? source;

  setUpAll(() {
    client = mocks.MockLaunchesInterface();
    source = LaunchesRepository(client!);
  });

  test('When response success, then SpaceXInfo is returned', () async {
    when(client?.getInfo()).thenAnswer((_) async => mocks.MockSpaceXInfo());

    SpaceXInfo? info = await source?.getInfo();

    expect(info, isA<SpaceXInfo>());
  });

  tearDownAll(() {
    client = null;
    source = null;
  });
}
