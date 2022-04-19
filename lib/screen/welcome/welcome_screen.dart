import 'package:flutter/material.dart';
import 'package:renderscan/screen/home/home_screen.dart';
import 'package:renderscan/screen/login/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    gettingStarted() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        ),
      );
    }

    var future = Future.delayed(const Duration(seconds: 2), gettingStarted);
    future.then((value) => (null));

    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/splash.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: null),
    );
  }
}
