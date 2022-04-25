import 'package:flutter/material.dart';
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/screen/home/home_screen.dart';
import 'package:renderscan/screen/login/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    authenticate(String? isAuth) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            if (isAuth != null) return HomeScreen();
            return LoginScreen();
          },
        ),
      );
    }

    var future = Future.delayed(
        const Duration(seconds: 2),
        () => Storage()
            .getItem("accessToken")
            .then((value) => authenticate(value)));
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
