import 'package:flutter/material.dart';
import 'package:inherited_widgets/inherited_widgets/inherited_counter_state.dart';

class CounterViewer extends StatelessWidget {
  const CounterViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int count = InheritedCounterState.of(context)?.count ?? 0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('$count clicks')],
    );
  }
}
