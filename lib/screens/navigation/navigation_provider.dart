import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;
  bool _cached = false;

  setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  setCache(bool cache) {
    _cached = cache;
  }

  get currentIndex => _currentIndex;
  get cached => _cached;
}
