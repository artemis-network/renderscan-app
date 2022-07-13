import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/nfts/nfts_mock.dart';
import 'package:renderscan/screen/nfts_collection/components/nft_collection_activity.dart';
import 'package:renderscan/screen/nfts_collection/components/nft_items_grid.dart';
import 'package:renderscan/screen/nfts_collection/nft_collection_model.dart';
import 'package:renderscan/screen/nfts_collection/nfts_collection_api.dart';

class NFTCollectionScreen extends StatefulWidget {
  final String slug;
  NFTCollectionScreen({required this.slug});

  @override
  State<NFTCollectionScreen> createState() => _NFTCollectionScreenState();
}

class _NFTCollectionScreenState extends State<NFTCollectionScreen> {
  int tabIndex = 0;

  final tabs = [
    NFTCollectionGridTab(nftItems: nfts),
    NFTCollectionActivityTab()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FutureBuilder(
                future: NFTCollectionAPI().getNFTCollectionBySlug("slug"),
                builder: ((context, snapshot) {
                  final data = snapshot.data as NFTCollection;
                  return Column(
                    children: [
                      Container(
                          child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          Image.network(
                            data.bannerUrl,
                            height: 112,
                            fit: BoxFit.fitWidth,
                          ),
                          Positioned(
                              top: 10,
                              left: 10,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_circle_left,
                                    color: context
                                        .watch<ThemeProvider>()
                                        .getBackgroundColor(),
                                    size: 50,
                                  ))),
                          Positioned(
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: context
                                        .watch<ThemeProvider>()
                                        .getBackgroundColor(),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 10,
                                          spreadRadius: 5,
                                          color: context
                                              .watch<ThemeProvider>()
                                              .getBackgroundColor())
                                    ],
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40))),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                          radius: 26,
                                          backgroundImage:
                                              NetworkImage(data.imageUrl),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      )),
                      Container(
                        height: 15,
                        width: double.infinity,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              offset: Offset(-5, -5),
                              spreadRadius: 10,
                              color: context
                                  .watch<ThemeProvider>()
                                  .getBackgroundColor()
                                  .withOpacity(0.88))
                        ]),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.name,
                                style: kPrimartFont(
                                    context
                                        .watch<ThemeProvider>()
                                        .getSecondaryFontColor(),
                                    16,
                                    FontWeight.normal),
                              ),
                              Text(
                                "by XV11",
                                style: kPrimartFont(
                                    context
                                        .watch<ThemeProvider>()
                                        .getPriamryFontColor(),
                                    14,
                                    FontWeight.bold),
                              ),
                            ],
                          )),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        child: Text(
                          data.description,
                          style: kPrimartFont(
                              context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
                              10,
                              FontWeight.normal),
                        ),
                      ),
                      CollectionStats(
                        floor: data.stats.floor_price,
                        items: data.stats.total_Supply,
                        owners: data.stats.num_owners,
                        volume: data.stats.one_day_volume,
                      )
                    ],
                  );
                })),
            Divider(thickness: 1),
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          tabIndex = 0;
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            "Items",
                            style: kPrimartFont(
                                tabIndex == 0
                                    ? context
                                        .watch<ThemeProvider>()
                                        .getHighLightColor()
                                    : Colors.black,
                                15,
                                FontWeight.normal),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Icon(Icons.list_alt_outlined,
                              color: tabIndex == 0
                                  ? context
                                      .watch<ThemeProvider>()
                                      .getHighLightColor()
                                  : Colors.black),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          tabIndex = 1;
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            "Acitivity",
                            style: kPrimartFont(
                                tabIndex == 1
                                    ? context
                                        .watch<ThemeProvider>()
                                        .getHighLightColor()
                                    : Colors.black,
                                15,
                                FontWeight.normal),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Icon(Icons.history_outlined,
                              color: tabIndex == 1
                                  ? context
                                      .watch<ThemeProvider>()
                                      .getHighLightColor()
                                  : Colors.black),
                        ],
                      ),
                    )
                  ]),
            ),
            Divider(thickness: 1),
            Expanded(
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: tabs[tabIndex]),
            )
          ],
        ),
      ),
    ));
  }
}

class CollectionStats extends StatelessWidget {
  final int items;
  final int owners;
  final String floor;
  final double volume;

  CollectionStats(
      {required this.items,
      required this.owners,
      required this.floor,
      required this.volume});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                items.toString(),
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
                    floor.toString(),
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
                    volume.toString(),
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

getBuild() {
  return;
}
