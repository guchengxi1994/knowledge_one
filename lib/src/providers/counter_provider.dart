import 'package:flutter/material.dart';
import 'package:knowledge_one/src/annotations/demo_annotation.dart';
import 'package:knowledge_one/src/native.dart';

@Demo("CounterProvider")
class CounterProvider extends ChangeNotifier {
  late Future<int> counter;

  init() {
    counter = api.getCounter();
  }

  void increament() {
    counter = api.increment();
    notifyListeners();
  }
}
