import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';

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
    var v = (double.parse(volume) / 1000).round().toString();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                totalSupply.toString(),
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
                    FontWeight.normal),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                owners.toString(),
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
                    FontWeight.normal),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    floorPrice.toString(),
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        14,
                        FontWeight.bold),
                  ),
                  Icon(
                    CryptoFontIcons.ETH,
                    size: 12,
                  )
                ],
              ),
              Text(
                "floor",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    12,
                    FontWeight.normal),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    v + "k",
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        14,
                        FontWeight.bold),
                  ),
                  Icon(
                    CryptoFontIcons.ETH,
                    size: 12,
                  )
                ],
              ),
              Text(
                "volume",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    12,
                    FontWeight.normal),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
