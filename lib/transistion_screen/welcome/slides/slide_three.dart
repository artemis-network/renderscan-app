import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/transistion_screen/welcome/slides/slide_four.dart';
import 'package:renderscan/transistion_screen/welcome/slides/slide_two.dart';

class SlideThree extends StatelessWidget {
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
            "Import + Mint NFTs",
            style: kPrimartFont(
                context.watch<ThemeProvider>().getPriamryFontColor(),
                22,
                FontWeight.bold),
          ),
          Text(
            "NFTs!",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () async {
                    Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: SlideTwo(),
                        ctx: context,
                        duration: Duration(milliseconds: 300),
                        fullscreenDialog: true,
                        childCurrent: this));
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
                    color: Colors.grey,
                  ),
                  Icon(
                    Icons.circle,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.circle,
                    color: Colors.grey,
                  ),
                  Icon(
                    Icons.circle,
                    color: Colors.grey,
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: SlideFour(),
                        ctx: context,
                        duration: Duration(milliseconds: 300),
                        fullscreenDialog: true,
                        childCurrent: this));
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    size: 32,
                    color: context.watch<ThemeProvider>().getFavouriteColor(),
                  )),
            ],
          ),
        ]),
      ),
    ));
  }
}
