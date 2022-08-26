import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/theme/theme_provider.dart';

class NFTCollectionScreenStats extends StatelessWidget {
  final String totalSupply;
  final String owners;
  final String floorPrice;
  final String volume;

  NFTCollectionScreenStats(
      {required this.totalSupply,
      required this.owners,
      required this.floorPrice,
      required this.volume});

  @override
  Widget build(BuildContext context) {
    var f = "--";
    if (floorPrice != "--") {
      f = double.parse(floorPrice).toStringAsFixed(2);
    }
    final v = (double.parse(volume) / 1000.00).toStringAsFixed(0) + "K";
    final i = (double.parse(totalSupply) / 1000.00).toStringAsFixed(1) + "K";
    final o = (double.parse(owners) / 1000.00).toStringAsFixed(1) + "K";
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                i,
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    14,
                    FontWeight.bold),
              ),
              Text(
                "items",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    12,
                    FontWeight.bold),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                o,
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    14,
                    FontWeight.bold),
              ),
              Text(
                "owners",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    12,
                    FontWeight.bold),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Icon(
                    CryptoFontIcons.ETH,
                    size: 12,
                    color: context.watch<ThemeProvider>().getPriamryFontColor(),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    f,
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        14,
                        FontWeight.bold),
                  ),
                ],
              ),
              Text(
                "floor",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    12,
                    FontWeight.bold),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Icon(
                    CryptoFontIcons.ETH,
                    size: 12,
                    color: context.watch<ThemeProvider>().getPriamryFontColor(),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    v,
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        14,
                        FontWeight.bold),
                  ),
                ],
              ),
              Text(
                "volume",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    12,
                    FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
