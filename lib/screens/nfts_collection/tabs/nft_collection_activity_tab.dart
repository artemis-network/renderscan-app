import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/theme/theme_provider.dart';

class NFTCollectionActivityTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        cacheExtent: 9999,
        itemCount: 10,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: context.watch<ThemeProvider>().getBackgroundColor(),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1,
                        offset: Offset(0, 0),
                        color: context
                            .watch<ThemeProvider>()
                            .getPriamryFontColor())
                  ]),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          "assets/images/lion.png",
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Doodle Lion #2123",
                            style: kPrimartFont(
                                context
                                    .watch<ThemeProvider>()
                                    .getPriamryFontColor(),
                                14,
                                FontWeight.normal),
                          ),
                          Row(
                            children: [
                              Text(
                                "Sold for " + 10.toString(),
                                style: kPrimartFont(
                                    context
                                        .watch<ThemeProvider>()
                                        .getPriamryFontColor(),
                                    14,
                                    FontWeight.bold),
                              ),
                              Icon(
                                CryptoFontIcons.ETH,
                                size: 12,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sale",
                        style: kPrimartFont(
                            context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            14,
                            FontWeight.bold),
                      ),
                      Text(
                        "3 hours ago",
                        style: kPrimartFont(
                            context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            14,
                            FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ));
        });
  }
}
