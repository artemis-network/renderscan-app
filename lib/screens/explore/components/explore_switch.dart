import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/theme/theme_provider.dart';

class ExploreSwitch extends StatelessWidget {
  final String search;
  final Function tabOne;
  final Function tabTwo;
  final int tabIndex;

  ExploreSwitch(
      {required this.search,
      required this.tabOne,
      required this.tabTwo,
      required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    getChipBG(int index) {
      return tabIndex == index
          ? context.watch<ThemeProvider>().getPriamryFontColor()
          : context.watch<ThemeProvider>().getBackgroundColor();
    }

    getChipShadow(int index) {
      return tabIndex == index
          ? context.watch<ThemeProvider>().getBackgroundColor()
          : context.watch<ThemeProvider>().getHighLightColor();
    }

    getChipFontColor(int index) {
      return tabIndex == index
          ? context.watch<ThemeProvider>().getBackgroundColor()
          : context.watch<ThemeProvider>().getPriamryFontColor();
    }

    return Container(
      color: context.watch<ThemeProvider>().getBackgroundColor(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => tabOne(),
            child: Chip(
              backgroundColor: getChipBG(0),
              shadowColor: getChipShadow(0),
              elevation: 2,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              avatar: Image.asset(
                "assets/icons/nfts.png",
                width: 32,
                height: 32,
              ),
              label: Text(
                'NFTs',
                style: kPrimartFont(getChipFontColor(0), 16, FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          InkWell(
            onTap: () => tabTwo(),
            child: Chip(
              backgroundColor: getChipBG(1),
              shadowColor: getChipShadow(1),
              elevation: 2,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              avatar: Image.asset(
                "assets/icons/collect.png",
                width: 32,
                height: 32,
              ),
              label: Text(
                'Collections',
                style: kPrimartFont(getChipFontColor(1), 16, FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
