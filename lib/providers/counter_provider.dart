import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  int _count = 10;
  int get counter => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    if (_count <= 0) {
      _count = 0;
    } else {
      _count--;
    }

    notifyListeners();
  }

  void reset() {
    _count = 0;
    notifyListeners();
  }
}
