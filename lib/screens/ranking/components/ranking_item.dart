import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:renderscan/screens/home/home_provider.dart';
import 'package:renderscan/screens/nfts_collection/nfts_collection_screen.dart';
import 'package:renderscan/theme/theme_provider.dart';

class RankingItem extends StatelessWidget {
  final String name;
  final String ranking;
  final String url;
  final String volume;
  final String totalValue;
  final String change;
  final String owners;
  final String slug;

  const RankingItem(
      {Key? key,
      required this.name,
      required this.ranking,
      required this.url,
      required this.volume,
      required this.totalValue,
      required this.change,
      required this.slug,
      required this.owners})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var o = (double.parse(owners) / 1000).toStringAsFixed(1) + "K";
    var color = Colors.green;
    if (change != "--") {
      final changed = double.parse(change);
      if (changed < 0) {
        color = Colors.red;
      }
      if (change == 0) {
        color = Colors.grey;
      }
    }
    final changed = double.parse(change).toStringAsFixed(2);

    getCurrentTimeFrame() {
      final String timeFrame =
          context.watch<HomeProvider>().currentTrendingrankingSortByTime;
      if (timeFrame == "daily") return "1d";
      if (timeFrame == "weekly") return "1w";
      if (timeFrame == "monthly") return "1m";
      return "";
    }

    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return NFTCollectionScreen(slug: slug);
          }));
        },
        child: Container(
            constraints: BoxConstraints(minHeight: size.height * 0.14),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: context.watch<ThemeProvider>().getBackgroundColor(),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 1,
                      color: context
                          .watch<ThemeProvider>()
                          .getHighLightColor()
                          .withOpacity(0.9),
                      offset: Offset(0, 0)),
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 36,
                          backgroundColor: context
                              .watch<ThemeProvider>()
                              .getBackgroundColor(),
                          backgroundImage: NetworkImage(
                            url,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: context
                                .watch<ThemeProvider>()
                                .getForegroundColor(),
                            child: Text(ranking),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: kPrimartFont(
                                      context
                                          .watch<ThemeProvider>()
                                          .getPriamryFontColor(),
                                      16,
                                      FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      totalValue,
                                      style: kPrimartFont(
                                          context
                                              .watch<ThemeProvider>()
                                              .getPriamryFontColor(),
                                          12,
                                          FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      CryptoFontIcons.ETH,
                                      size: 12,
                                      color: context
                                          .watch<ThemeProvider>()
                                          .getPriamryFontColor(),
                                    )
                                  ],
                                )
                              ])
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Text(
                                changed + "%",
                                style: kPrimartFont(color, 14, FontWeight.bold),
                              ),
                              Text(
                                getCurrentTimeFrame(),
                                style: kPrimartFont(
                                    context
                                        .watch<ThemeProvider>()
                                        .getPriamryFontColor(),
                                    14,
                                    FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Text(
                                o,
                                style: kPrimartFont(
                                    context
                                        .watch<ThemeProvider>()
                                        .getPriamryFontColor(),
                                    14,
                                    FontWeight.bold),
                              ),
                              Text(
                                "Owners",
                                style: kPrimartFont(
                                    context
                                        .watch<ThemeProvider>()
                                        .getPriamryFontColor(),
                                    14,
                                    FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            )));
  }
}
