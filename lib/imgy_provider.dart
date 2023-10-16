import 'package:flutter/material.dart';

class CounterProvider extends InheritedWidget {
  final int counter;

  const CounterProvider({
    required Key key,
    required this.counter,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  static CounterProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(CounterProvider oldWidget) {
    return oldWidget.counter != counter;
  }
}
