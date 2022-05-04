import 'package:bloc_sample/bloc/bloc_counter.dart';
import 'package:bloc_sample/models/counter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BLoCHomePage extends StatefulWidget {
  const BLoCHomePage({Key? key}) : super(key: key);

  @override
  State<BLoCHomePage> createState() => _BLoCHomePageState();
}

class _BLoCHomePageState extends State<BLoCHomePage> {
  final _initialCounter = Counter(2);
  late final CounterBloc _counterBloc;

  @override
  void initState() {
    super.initState();
    _counterBloc = CounterBloc(_initialCounter);
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider(
        create: (context) => _counterBloc.counterStream,
        initialData: _initialCounter,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('BLoC Sample'),
          ),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('You have pushed the button this many times:'),
              Consumer<Counter>(
                  builder: (context, counter, _) => Text('${counter.value}')),
            ],
          )),
          floatingActionButton: FloatingActionButton(
            onPressed: _increment,
            child: const Icon(Icons.add),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _counterBloc.dispose();
  }

  void _increment() {
    _counterBloc.increment();
  }
}
