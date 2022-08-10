import '../../models/launch.dart';

abstract class LaunchState {
  List<Launch> launches;

  LaunchState({required this.launches});
}

class InitState extends LaunchState {
  InitState({required List<Launch> launches}) : super(launches: []);
}

class SuccessState extends LaunchState {
  SuccessState({required List<Launch> launches}) : super(launches: launches);
}

class ErrorState extends LaunchState {
  final String error;
  ErrorState({required this.error}) : super(launches: []);
}

class FilterState extends LaunchState {
  FilterState({required List<Launch> launches}) : super(launches: launches);
}
