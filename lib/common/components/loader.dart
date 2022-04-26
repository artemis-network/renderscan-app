import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:renderscan/constants.dart';

final spinkit = WillPopScope(
    child: SpinKitCubeGrid(color: kprimaryLoaderColor, size: 100),
    onWillPop: () async => false);
