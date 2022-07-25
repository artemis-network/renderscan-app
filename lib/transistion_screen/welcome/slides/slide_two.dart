import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/transistion_screen/welcome/slides/slide_one.dart';
import 'package:renderscan/transistion_screen/welcome/slides/slide_three.dart';

class SlideTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        child: Column(children: [
          SizedBox(
            height: 120,
          ),
          Text(
            "Mint NFTs!",
            style: kPrimartFont(
                context.watch<ThemeProvider>().getPriamryFontColor(),
                22,
                FontWeight.bold),
          ),
          SizedBox(
            height: 40,
          ),
          SvgPicture.asset(
            "assets/images/default_img.svg",
            height: 240,
            width: 240,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 40,
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(PageTransition(
                    type: PageTransitionType.leftToRight,
                    child: SlideThree(),
                    ctx: context,
                    duration: Duration(milliseconds: 300),
                    fullscreenDialog: true,
                    childCurrent: this));
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: context.watch<ThemeProvider>().getBackgroundColor(),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color: context
                              .watch<ThemeProvider>()
                              .getHighLightColor())
                    ]),
                alignment: Alignment.center,
                child: Text("Next",
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        34,
                        FontWeight.bold)),
              )),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(PageTransition(
                    type: PageTransitionType.leftToRight,
                    child: SlideOne(),
                    ctx: context,
                    duration: Duration(milliseconds: 300),
                    fullscreenDialog: true,
                    childCurrent: this));
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: context.watch<ThemeProvider>().getBackgroundColor(),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color: context
                              .watch<ThemeProvider>()
                              .getHighLightColor())
                    ]),
                alignment: Alignment.center,
                child: Text("Back",
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        34,
                        FontWeight.bold)),
              ))
        ]),
      ),
    ));
  }
}
