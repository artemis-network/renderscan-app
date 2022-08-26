import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:renderscan/screens/home/home_provider.dart';
import 'package:renderscan/screens/navigation/navigation_screen.dart';
import 'package:renderscan/screens/welcome/slides/slide_one.dart';
import 'package:renderscan/theme/theme_provider.dart';
import 'package:renderscan/utils/storage.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<HomeProvider>().initializeHomePage();
    var future = Future.delayed(const Duration(milliseconds: 5000), () async {
      final value = await Storage().isFirstTime();

      if (value.toString() == "true") {
        return Navigator.push(context,
            MaterialPageRoute(builder: (context) => NavigationScreen()));
      }
      return Navigator.push(
          context, MaterialPageRoute(builder: (context) => SlideOne()));
    });

    future.then((value) {});

    return Scaffold(
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(
          children: [
            Image.asset(
              "assets/images/main_logo.png",
              height: 160,
              width: 160,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
              child: Text(
                "RENDERVERSE",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    32,
                    FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
              child: Text(
                "Create, Design, & Mint NFTs",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    20,
                    FontWeight.normal),
              ),
            ),
          ],
        ),
        Lottie.asset("assets/lottie/splash.json",
            width: 420, height: 420, fit: BoxFit.fill),
      ]),
    );
  }
}
