import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/transistion_screen/welcome/slides/slide_three.dart';
import 'package:renderscan/transistion_screen/welcome/slides/slides_five.dart';

class SlideFour extends StatelessWidget {
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
            "Buy & Sell NFTs",
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
                  onPressed: () {
                    Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: SlideThree(),
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
                ],
              ),
              IconButton(
                  onPressed: () async {
                    await Storage().setFirstTime(true);
                    Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: SlideFive(),
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
          )
        ]),
      ),
    ));
  }
}
