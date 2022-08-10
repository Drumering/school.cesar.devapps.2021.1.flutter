import 'package:flutter/widgets.dart';

abstract class LaunchEvent {
  late final BuildContext context;
}

class LoadLaunchesEvent implements LaunchEvent {
  @override
  BuildContext context;
  LoadLaunchesEvent({required this.context});
}

class FilterLaunchesByYearEvent implements LaunchEvent {
  final String year;

  @override
  BuildContext context;

  FilterLaunchesByYearEvent({required this.year, required this.context});
}

class FilterLaunchesBySuccessEvent implements LaunchEvent {
  final bool success;

  @override
  BuildContext context;

  FilterLaunchesBySuccessEvent({required this.success, required this.context});
}

class FilterLaunchesByFailureEvent implements LaunchEvent {
  final bool failure;

  @override
  BuildContext context;

  FilterLaunchesByFailureEvent({required this.failure, required this.context});
}
