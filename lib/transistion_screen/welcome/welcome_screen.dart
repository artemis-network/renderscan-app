import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:renderscan/static_screen/home/home_provider.dart';
import 'package:renderscan/static_screen/navigation/navigation_screen.dart';
import 'package:renderscan/transistion_screen/welcome/slides/slide_one.dart';

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
      final value = await Storage().isFirstTime().toString();
      if (value.toString() == "true") {
        return Navigator.push(context,
            MaterialPageRoute(builder: (context) => NavigationScreen()));
      }
      return Navigator.push(
          context, MaterialPageRoute(builder: (context) => SlideOne()));
    });

    future.then((value) {});

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
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
          Lottie.asset("assets/lottie/splash.json",
              fit: BoxFit.fitWidth, height: 450),
        ]),
      ),
    );
  }
}
