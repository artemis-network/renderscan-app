import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  int? _currentIndex = 2;

  setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  get currentIndex => _currentIndex;
}
