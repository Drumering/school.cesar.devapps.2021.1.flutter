// Mocks generated by Mockito 5.2.0 from annotations
// in spacex_launches/test/http_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:spacex_launches/abstracts/launches_interface.dart' as _i3;
import 'package:spacex_launches/models/launch.dart' as _i5;
import 'package:spacex_launches/models/spacex_info.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeSpaceXInfo_0 extends _i1.Fake implements _i2.SpaceXInfo {}

/// A class which mocks [LaunchesInterface].
///
/// See the documentation for Mockito's code generation for more information.
class MockLaunchesInterface extends _i1.Mock implements _i3.LaunchesInterface {
  MockLaunchesInterface() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i5.Launch>> getLaunches() =>
      (super.noSuchMethod(Invocation.method(#getLaunches, []),
              returnValue: Future<List<_i5.Launch>>.value(<_i5.Launch>[]))
          as _i4.Future<List<_i5.Launch>>);
  @override
  _i4.Future<_i2.SpaceXInfo> getInfo() =>
      (super.noSuchMethod(Invocation.method(#getInfo, []),
              returnValue: Future<_i2.SpaceXInfo>.value(_FakeSpaceXInfo_0()))
          as _i4.Future<_i2.SpaceXInfo>);
}

/// A class which mocks [SpaceXInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockSpaceXInfo extends _i1.Mock implements _i2.SpaceXInfo {
  MockSpaceXInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get name =>
      (super.noSuchMethod(Invocation.getter(#name), returnValue: '') as String);
  @override
  String get founder =>
      (super.noSuchMethod(Invocation.getter(#founder), returnValue: '')
          as String);
  @override
  int get founded =>
      (super.noSuchMethod(Invocation.getter(#founded), returnValue: 0) as int);
  @override
  int get employees =>
      (super.noSuchMethod(Invocation.getter(#employees), returnValue: 0)
          as int);
  @override
  int get launchSites =>
      (super.noSuchMethod(Invocation.getter(#launchSites), returnValue: 0)
          as int);
  @override
  int get valuation =>
      (super.noSuchMethod(Invocation.getter(#valuation), returnValue: 0)
          as int);
  @override
  Map<String, dynamic> toJson() =>
      (super.noSuchMethod(Invocation.method(#toJson, []),
          returnValue: <String, dynamic>{}) as Map<String, dynamic>);
}
