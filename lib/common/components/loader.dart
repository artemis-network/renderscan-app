import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';

final spinkit = WillPopScope(
    child: Container(
        alignment: Alignment.center,
        child: SpinKitCubeGrid(color: Colors.blueGrey, size: 100)),
    onWillPop: () async => false);
