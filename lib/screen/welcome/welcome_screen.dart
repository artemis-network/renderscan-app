import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/home/home_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:renderscan/screen/login/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    var future = Future.delayed(const Duration(milliseconds: 5000), () async {
      // var isUserLoggedIn = await Storage().getItem("username");
      // log.i(isUserLoggedIn);
      // if (isUserLoggedIn != null) {
      return Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
      // } else {
      //   return Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => LoginScreen()));
      // }
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
          Container(
            color: context.watch<ThemeProvider>().getBackgroundColor(),
            child: Lottie.asset("assets/lottie/splash.json",
                height: 450, fit: BoxFit.fitWidth),
          ),
        ]),
      ),
    );
  }
}
