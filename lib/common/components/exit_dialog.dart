import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class AppExitDialogWrapper extends StatefulWidget {
  final Widget child;
  AppExitDialogWrapper({Key? key, required this.child}) : super(key: key);

  @override
  State<AppExitDialogWrapper> createState() => App_ExitDialogStateWrapper();
}

class App_ExitDialogStateWrapper extends State<AppExitDialogWrapper> {
  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: new AutoSizeText('Are you sure?'),
              content: new AutoSizeText('Do you want to exit an App'),
              actions: <Widget>[
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(false), //<-- SEE HERE
                  child: new AutoSizeText('No'),
                ),
                TextButton(
                  onPressed: () {
                    if (Platform.isAndroid)
                      SystemNavigator.pop();
                    else
                      exit(0);
                  },
                  child: new AutoSizeText('Yes'),
                ),
              ],
            ),
          )) ??
          false;
    }

    return new WillPopScope(child: widget.child, onWillPop: _onWillPop);
  }
}
