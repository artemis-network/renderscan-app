import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ScanProvider extends ChangeNotifier {
  Uint8List? _imgSource;
  bool? _isFetched = false;
  bool? _isLoading = false;

  setScanStatus(String base64ImageString) {
    _imgSource = const Base64Codec().decode(base64ImageString.toString());
    _isFetched = true;
    notifyListeners();
  }

  setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  resetProvider() {
    _imgSource = null;
    _isFetched = false;
    _isLoading = false;
    notifyListeners();
  }

  get imageSource => _imgSource;
  get isFetched => _isFetched;
  get isLoading => _isLoading;
}
