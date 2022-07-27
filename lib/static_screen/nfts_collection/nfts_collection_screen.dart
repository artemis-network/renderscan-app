import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/loader.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/static_screen/nfts_collection/components/nft_collection_screen_banenr.dart';
import 'package:renderscan/static_screen/nfts_collection/components/nft_collection_screen_stats.dart';
import 'package:renderscan/static_screen/nfts_collection/models/nft_collection.model.dart';
import 'package:renderscan/static_screen/nfts_collection/nfts_collection_api.dart';

import 'package:renderscan/static_screen/nfts_collection/tabs/nft_collections_nft_items_grid_tab.dart';

class NFTCollectionScreen extends StatefulWidget {
  final String slug;
  NFTCollectionScreen({required this.slug});

  @override
  State<NFTCollectionScreen> createState() => _NFTCollectionScreenState();
}

class _NFTCollectionScreenState extends State<NFTCollectionScreen> {
  bool showDesription = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          color: context.watch<ThemeProvider>().getBackgroundColor(),
          child: SingleChildScrollView(
            child: FutureBuilder(
                future: NFTCollectionAPI().getNFTCollectionBySlug(widget.slug),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    final NFTCollectionModel nftCollection =
                        snapshot.data as NFTCollectionModel;

                    descriptionFetcher() {
                      if (showDesription) {
                        return Text(
                          nftCollection.description,
                          style: kPrimartFont(
                              context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
                              10,
                              FontWeight.normal),
                        );
                      }
                      return Text(
                        nftCollection.description.substring(0, 150) + "...",
                        style: kPrimartFont(
                            context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            10,
                            FontWeight.normal),
                      );
                    }

                    return Column(children: [
                      NFTCollectScreenBanner(
                          bannerUrl: nftCollection.bannerUrl,
                          imageUrl: nftCollection.imageUrl),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nftCollection.name,
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
                        padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                        child: descriptionFetcher(),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 30),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              showDesription = !showDesription;
                            });
                          },
                          child: Text(
                            !showDesription ? "view more" : "hide",
                            textAlign: TextAlign.left,
                            style: kPrimartFont(
                                context
                                    .watch<ThemeProvider>()
                                    .getPriamryFontColor(),
                                10,
                                FontWeight.bold),
                          ),
                        ),
                      ),
                      NFTCollectionScreenStats(
                        floorPrice: nftCollection.floorPrice.toString(),
                        totalSupply: nftCollection.totalSuppy,
                        owners: nftCollection.owners,
                        volume: nftCollection.totalVolume,
                      ),
                      Divider(thickness: 1),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: NFTCollectionNFTItemsGridTab(
                          nftItems: nftCollection.nfts,
                        ),
                      )
                    ]);
                  }
                  return Container(
                    alignment: Alignment.center,
                    child: spinkit,
                  );
                })),
          ),
        ),
      ),
    );
  }
}
