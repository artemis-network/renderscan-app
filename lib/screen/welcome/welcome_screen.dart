import 'package:flutter/material.dart';
import 'package:renderscan/screen/home/home_screen.dart';
import 'package:renderscan/screen/login/login_screen.dart';
import 'package:renderscan/screen/mint/mint_screen.dart';
import 'package:renderscan/screen/scan/scan_provider.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    gettingStarted() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            // return MintScreen(img: context.watch<ScanProvider>().imageSource);
            return HomeScreen();
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
