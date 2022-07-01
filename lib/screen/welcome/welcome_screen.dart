import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/home/home_screen.dart';
import 'package:renderscan/screen/login/login_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final List<String> _text = ["Let's", "Create", "Design", "NFT's"];
  final List<Color> _colors = [
    Colors.blue,
    Colors.purple,
    Colors.deepOrange,
    Colors.cyan,
    Colors.indigo
  ];
  double _width = 100;
  double _height = 100;
  double _fontSize = 24;
  int _index = 0;
  List<String> _createdText = ["Tap"];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    var future = Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });

    future.then((value) {});

    return Scaffold(
      body: Container(
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
