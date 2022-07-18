import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/balance_widet.dart';
import 'package:renderscan/common/theme/theme_provider.dart';

class Topbar extends StatelessWidget {
  final Function popSideBar;

  Topbar({required this.popSideBar});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        border: Border(
            bottom: BorderSide(
                width: 0.5,
                color: context
                    .watch<ThemeProvider>()
                    .getHighLightColor()
                    .withOpacity(0.33))),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        InkWell(
            radius: 20,
            child: IconButton(
              icon: Icon(
                Icons.menu,
                size: 40,
                color: context.watch<ThemeProvider>().getPriamryFontColor(),
              ),
              onPressed: () {
                popSideBar();
              },
              color: context.watch<ThemeProvider>().getFavouriteColor(),
            )),
        BalanceWidget()
      ]),
    );
  }
}
