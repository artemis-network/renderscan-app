import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/wallet/wallet_api.dart';
import 'package:renderscan/screen/wallet/wallet_dto.dart';

class WalletBanner extends StatefulWidget {
  final Size size;
  WalletBanner({Key? key, required this.size});
  @override
  State<WalletBanner> createState() => _WalletBannerState();
}

class _WalletBannerState extends State<WalletBanner> {
  @override
  Widget build(BuildContext context) {
    Future<Wallet> setUpWallet() async {
      final username = await Storage().getItem("username");
      return await WalletApi().getBalance(username.toString());
    }

    getBalance() {
      return FutureBuilder(
          future: setUpWallet(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState.name == "done") {
              final data = snapshot.data as Wallet;
              return Text(
                data.balance.toString() + " RNDV",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    18,
                    FontWeight.bold),
              );
            } else {
              return Text(
                0.toString() + " RNDV",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    18,
                    FontWeight.bold),
              );
            }
          });
    }

    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
        decoration: BoxDecoration(
            color: context.watch<ThemeProvider>().getBackgroundColor(),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 500,
                  color: context
                      .watch<ThemeProvider>()
                      .getHighLightColor()
                      .withOpacity(0.33),
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
