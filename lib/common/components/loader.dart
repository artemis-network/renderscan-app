import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final spinkit = WillPopScope(
    child: Container(
        alignment: Alignment.center,
        child: SpinKitCubeGrid(color: Colors.blueGrey, size: 100)),
    onWillPop: () async => false);
