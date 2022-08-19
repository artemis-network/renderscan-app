import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

spinkit() {
  return WillPopScope(
      child: Container(
        alignment: Alignment.center,
        child: SpinKitWave(color: Colors.blueGrey, size: 50),
      ),
      onWillPop: () async => false);
}
