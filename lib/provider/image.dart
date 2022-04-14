import 'dart:convert';
import 'package:flutter/material.dart';

class ImageP with ChangeNotifier {
  var _decodeImg;

  get decodedImg => _decodeImg;

  void setImage(baseStr) {
    _decodeImg = const Base64Codec().decode(baseStr);
    notifyListeners();
  }
}
