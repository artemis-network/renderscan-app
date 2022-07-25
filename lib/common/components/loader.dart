import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final spinkit = WillPopScope(
    child: Container(
        alignment: Alignment.center,
        child: SpinKitDoubleBounce(color: Colors.grey, size: 100)),
    onWillPop: () async => false);
