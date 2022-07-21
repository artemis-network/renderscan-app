import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int? _currentIndex = 0;

  setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  get currentIndex => _currentIndex;
}