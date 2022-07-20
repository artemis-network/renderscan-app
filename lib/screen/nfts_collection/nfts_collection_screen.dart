import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/nfts_collection/components/nft_collection_activity.dart';
import 'package:renderscan/screen/nfts_collection/components/nft_items_grid.dart';
import 'package:renderscan/screen/nfts_collection/nfts_collection_api.dart';

class NFTCollectionScreen extends StatefulWidget {
  final String slug;
  NFTCollectionScreen({required this.slug});

  @override
  State<NFTCollectionScreen> createState() => _NFTCollectionScreenState();
}

class _NFTCollectionScreenState extends State<NFTCollectionScreen> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          color: context.watch<ThemeProvider>().getBackgroundColor(),
          child: FutureBuilder(
              future: NFTCollectionAPI().getNFTCollectionBySlug(widget.slug),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  final NFTCollectionDTO nftCollectionDTO =
                      snapshot.data as NFTCollectionDTO;
                  return Column(
                    children: [
                      Container(
                          child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          Image.network(
                            nftCollectionDTO.bannerUrl,
                            height: 140,
                            fit: BoxFit.fill,
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
                                          blurRadius: 2,
                                          spreadRadius: 0,
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
                                          backgroundImage: NetworkImage(
                                              nftCollectionDTO.imageUrl),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  blurRadius: 5,
                                  offset: Offset(-2, -2),
                                  spreadRadius: 5,
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
                                    nftCollectionDTO.name,
                                    style: kPrimartFont(
                                        context
                                            .watch<ThemeProvider>()
                                            .getSecondaryFontColor(),
                                        16,
                                        FontWeight.normal),
                                  ),
                                  Text(
                                    "by " + widget.slug,
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
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            child: Text(
                              nftCollectionDTO.description.length > 150
                                  ? nftCollectionDTO.description
                                          .substring(0, 150) +
                                      "..."
                                  : nftCollectionDTO.description,
                              style: kPrimartFont(
                                  context
                                      .watch<ThemeProvider>()
                                      .getPriamryFontColor(),
                                  10,
                                  FontWeight.normal),
                            ),
                          ),
                          CollectionStats(
                            floor: nftCollectionDTO.stats.floor.toString(),
                            items: nftCollectionDTO.stats.total_supply,
                            owners: nftCollectionDTO.stats.num_owners,
                            volume: nftCollectionDTO.stats.total_volume,
                          ),
                          Divider(thickness: 1),
                          Container(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                          tabIndex == 0
                              ? FutureBuilder(
                                  future: NFTCollectionAPI()
                                      .getNFTsBySlug(widget.slug),
                                  builder: ((context, snapshot) {
                                    if (snapshot.hasData) {
                                      final List<NFTDTO> nfts =
                                          snapshot.data as List<NFTDTO>;
                                      return NFTCollectionGridTab(
                                          nftItems: nfts);
                                    }
                                    return Container(
                                      child: CircularProgressIndicator(),
                                      height: 60,
                                      width: 60,
                                      alignment: Alignment.center,
                                    );
                                  }))
                              : NFTCollectionActivityTab()
                        ],
                      )),
                    ],
                  );
                }
                return Container(
                  height: 60,
                  width: 60,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              })),
        ),
      ),
    );
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
    var v = (volume / 1000).round().toString();
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

getBuild() {
  return;
}
