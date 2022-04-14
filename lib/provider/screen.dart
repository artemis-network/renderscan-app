import 'package:flutter/material.dart';

class ScreenStateProvider with ChangeNotifier {
  late int _currentIndex = 0;

  get currentIndex => _currentIndex;

  void setPage(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
