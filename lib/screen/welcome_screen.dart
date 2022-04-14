import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:renderscan/screen/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  List<CameraDescription> cameras;

  WelcomeScreen({Key? key, required this.cameras}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    gettingStarted() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen(
              cameras: cameras,
            );
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
