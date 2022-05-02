import 'dart:typed_data';

import 'package:flutter/material.dart';

class ScanProvider extends ChangeNotifier {
  Uint8List? _imgSource;
  String? _filename;
  bool? _isFetched = false;
  bool? _isLoading = false;

  setScanStatus(Uint8List imageSource, String filename) {
    _imgSource = imageSource;
    _filename = filename;
    _isFetched = true;
    notifyListeners();
  }

  setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  resetProvider() {
    _imgSource = null;
    _filename = null;
    _isFetched = false;
    _isLoading = false;
    notifyListeners();
  }

  get filename => _filename;
  get imageSource => _imgSource;
  get isFetched => _isFetched;
  get isLoading => _isLoading;
}
