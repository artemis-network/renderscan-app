import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/wallet/wallet_screen.dart';

class WalletButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => WalletScreen()));
      },
      child: Container(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(children: [
              Text("0",
                  style: kPrimartFont(
                      context.watch<ThemeProvider>().getBackgroundColor(),
                      18,
                      FontWeight.w800)),
              Icon(Icons.attach_money_outlined,
                  color: context.watch<ThemeProvider>().getBackgroundColor()),
            ]),
            decoration: BoxDecoration(
                color: context.watch<ThemeProvider>().getPriamryFontColor(),
                borderRadius: BorderRadius.circular(10)),
          ),
        ]),
      ),
    );
  }
}

class Topbar extends StatelessWidget {
  Function popSideBar;

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
      child: Flexible(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
          Container(
              child: Text("Renderscan",
                  style: kPrimartFont(
                      context.watch<ThemeProvider>().getPriamryFontColor(),
                      26,
                      FontWeight.w800))),
          WalletButton()
        ]),
      ),
    );
  }
}
