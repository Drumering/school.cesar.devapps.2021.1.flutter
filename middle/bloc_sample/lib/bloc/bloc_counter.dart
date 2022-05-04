import 'dart:async';

import 'package:bloc_sample/abstracts/bloc.dart';
import 'package:bloc_sample/models/counter.dart';

class CounterBloc extends Bloc {
  final Counter _counter;

  final _counterController = StreamController<Counter>();

  Stream<Counter> get counterStream => _counterController.stream;

  CounterBloc(this._counter) {
    _counterController.add(_counter);
  }

  void increment() {
    // Counter newCounter = await Future.delayed(const Duration(seconds: 2), () {
    //   _counter.increment();
    //   return Counter(_counter.value);
    // });
    // print(newCounter.value);
    // _counterController.sink.add(newCounter);

    _counter.increment();
    _counterController.sink.add(Counter(_counter.value));
  }

  @override
  void dispose() {
    _counterController.close();
  }
}
