import 'package:flutter/widgets.dart';

class InheritedCounterState extends InheritedWidget {
  const InheritedCounterState(
      {Key? key, required this.count, required Widget child})
      : super(key: key, child: child);

  final int count;

  @override
  bool updateShouldNotify(covariant InheritedCounterState oldWidget) {
    return oldWidget.count != count;
  }

  static InheritedCounterState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedCounterState>();
  }
}
