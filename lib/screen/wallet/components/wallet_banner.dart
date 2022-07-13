import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';

class WalletBanner extends StatefulWidget {
  final Size size;
  WalletBanner({Key? key, required this.size});
  @override
  State<WalletBanner> createState() => _WalletBannerState();
}

class _WalletBannerState extends State<WalletBanner> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
        decoration: BoxDecoration(
            color: context.watch<ThemeProvider>().getBackgroundColor(),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 1,
                  color: context.watch<ThemeProvider>().getHighLightColor(),
                  offset: Offset(0, 0)),
            ]),
        height: widget.size.height * 0.15,
        width: widget.size.width * 0.9,
        child: Row(children: [
          Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Balance",
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getHighLightColor(),
                        14,
                        FontWeight.bold),
                  ),
                  Text(
                    0.toString() + " RNDV",
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        18,
                        FontWeight.bold),
                  )
                ],
              )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Account",
                  style: kPrimartFont(
                      context.watch<ThemeProvider>().getHighLightColor(),
                      14,
                      FontWeight.bold),
                ),
                Text(
                  "0xcff8...",
                  style: kPrimartFont(
                      context.watch<ThemeProvider>().getPriamryFontColor(),
                      18,
                      FontWeight.bold),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
