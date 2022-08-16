import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/theme/theme_provider.dart';

class NFTCollectionTabSwitch extends StatelessWidget {
  final int tabIndex;
  final Function setTabOne;
  final Function setTabTwo;

  NFTCollectionTabSwitch(
      {required this.tabIndex,
      required this.setTabOne,
      required this.setTabTwo});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        InkWell(
          onTap: () {
            setTabOne();
          },
          child: Row(
            children: [
              Text(
                "Items",
                style: kPrimartFont(
                    tabIndex == 0
                        ? context.watch<ThemeProvider>().getHighLightColor()
                        : context.watch<ThemeProvider>().getPriamryFontColor(),
                    15,
                    FontWeight.normal),
              ),
              SizedBox(
                width: 2,
              ),
              Icon(Icons.list_alt_outlined,
                  color: tabIndex == 0
                      ? context.watch<ThemeProvider>().getHighLightColor()
                      : context.watch<ThemeProvider>().getPriamryFontColor()),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            setTabTwo();
          },
          child: Row(
            children: [
              Text(
                "Acitivity",
                style: kPrimartFont(
                    tabIndex == 1
                        ? context.watch<ThemeProvider>().getHighLightColor()
                        : context.watch<ThemeProvider>().getPriamryFontColor(),
                    15,
                    FontWeight.normal),
              ),
              SizedBox(
                width: 2,
              ),
              Icon(Icons.history_outlined,
                  color: tabIndex == 1
                      ? context.watch<ThemeProvider>().getHighLightColor()
                      : context.watch<ThemeProvider>().getPriamryFontColor()),
            ],
          ),
        )
      ]),
    );
  }
}
