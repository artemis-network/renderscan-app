import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/wallet/create_wallet.screen.dart';
import 'package:renderscan/screens/welcome/slides/getting_started.dart';
import 'package:renderscan/theme/theme_provider.dart';

class Slides extends StatefulWidget {
  @override
  State<Slides> createState() => _SlidesState();
}

class _SlidesState extends State<Slides> {
  final List<String> titles = [
    "Create + Design NFTs",
    "Import + Mint NFTs!",
    "Buy & Sell NFTs",
    "Remove Background"
  ];
  final List<String> urls = [
    "assets/splash/2.png",
    "assets/splash/1.png",
    "assets/splash/3.png",
    "assets/splash/4.png"
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        child: Column(children: [
          SizedBox(
            height: 120,
          ),
          Text(
            titles[currentIndex],
            style: kPrimartFont(
                context.watch<ThemeProvider>().getPriamryFontColor(),
                22,
                FontWeight.bold),
          ),
          SizedBox(
            height: 40,
          ),
          Image.asset(
            urls[currentIndex],
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () async {
                    if (currentIndex == 0) {
                      Navigator.of(context).push(PageTransition(
                          type: PageTransitionType.leftToRight,
                          child: GettingStarted(),
                          ctx: context,
                          duration: Duration(milliseconds: 300),
                          fullscreenDialog: true,
                          childCurrent: Slides()));
                    }
                    if (currentIndex > 0) {
                      setState(() {
                        currentIndex -= 1;
                      });
                    }
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: context.watch<ThemeProvider>().getFavouriteColor(),
                  )),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 10,
                    color: currentIndex == 0 ? Colors.white : Colors.grey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.circle,
                    size: 10,
                    color: currentIndex == 1 ? Colors.white : Colors.grey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.circle,
                    size: 10,
                    color: currentIndex == 2 ? Colors.white : Colors.grey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.circle,
                    size: 10,
                    color: currentIndex == 3 ? Colors.white : Colors.grey,
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {
                    if (currentIndex == 3) {
                      Navigator.of(context).push(PageTransition(
                          type: PageTransitionType.leftToRight,
                          child: CreateWalletScreen(),
                          ctx: context,
                          duration: Duration(milliseconds: 300),
                          fullscreenDialog: true,
                          childCurrent: Slides()));
                    }
                    if (currentIndex < 3) {
                      setState(() {
                        currentIndex += 1;
                      });
                    }
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    size: 32,
                    color: context.watch<ThemeProvider>().getFavouriteColor(),
                  )),
            ],
          ),
          currentIndex == 3
              ? Container(
                  child: Text(
                    "Start your Journey",
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        15,
                        FontWeight.bold),
                  ),
                )
              : Container()
        ]),
      ),
    );
  }
}
