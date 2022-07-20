import 'package:flutter/material.dart';
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/common/components/loader.dart';

class AuthFilter extends StatelessWidget {
  final Widget screen;
  final Widget guestView;

  AuthFilter({required this.screen, required this.guestView});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Storage().isLoggedIn(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState.name == "done") {
          final isLoggedIn = snapshot.data as bool;
          if (isLoggedIn) return screen;
          return guestView;
        }
        return Container(
          child: spinkit,
          alignment: Alignment.center,
        );
      },
    );
  }
}
