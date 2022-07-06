import 'package:flutter/material.dart';
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/common/components/loader.dart';
import 'package:renderscan/screen/login/login_screen.dart';

class AuthFilter extends StatelessWidget {
  final Widget screen;
  final bool returnLoginPage;

  AuthFilter({required this.screen, required this.returnLoginPage});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Storage().isLoggedIn(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState.name == "done") {
          final isLoggedIn = snapshot.data as bool;
          if (isLoggedIn) return screen;

          if (!isLoggedIn && returnLoginPage) return LoginScreen();
          return Text("");
        }
        return Container(
          child: spinkit,
          alignment: Alignment.center,
        );
      },
    );
  }
}
