import 'package:flutter/material.dart';
import 'package:inherited_widgets/inherited_widgets/inherited_counter_state.dart';
import 'package:inherited_widgets/inherited_widgets/inherited_counter_viewer.dart';

class InheritedHome extends StatefulWidget {
  const InheritedHome({Key? key}) : super(key: key);

  @override
  State<InheritedHome> createState() => _InheritedHomeState();
}

class _InheritedHomeState extends State<InheritedHome> {
  int _count = 0;

  void _incrementCount() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InheritedCounterState(
        count: _count,
        child: Scaffold(
          appBar: AppBar(title: const Text('Inherited Home Counter')),
          body: const Center(
            child: CounterViewer(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _incrementCount,
            child: const Icon(Icons.add),
          ),
        ));
  }
}
