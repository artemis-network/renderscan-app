import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/nfts_collection/components/nft_collection_screen_banenr.dart';
import 'package:renderscan/screens/nfts_collection/components/nft_collection_screen_stats.dart';
import 'package:renderscan/screens/nfts_collection/models/nft.model.dart';
import 'package:renderscan/screens/nfts_collection/models/nft_collection.model.dart';
import 'package:renderscan/screens/nfts_collection/nfts_collection_api.dart';
import 'package:renderscan/screens/nfts_collection/tabs/nft_collections_nft_items_grid_tab.dart';
import 'package:renderscan/theme/theme_provider.dart';
import 'package:skeletons/skeletons.dart';

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
          color: context.watch<ThemeProvider>().getBackgroundColor(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder(
                    future:
                        NFTCollectionAPI().getNFTCollectionBySlug(widget.slug),
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
                            padding:
                                EdgeInsets.only(top: 10, left: 30, right: 30),
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
                        ]);
                      }
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 0),
                        child: SkeletonItem(
                            child: Column(
                          children: [
                            SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                width: double.infinity,
                                minHeight:
                                    MediaQuery.of(context).size.height / 8,
                                maxHeight:
                                    MediaQuery.of(context).size.height / 3,
                              ),
                            ),
                            SizedBox(height: 12),
                            SkeletonParagraph(
                              style: SkeletonParagraphStyle(
                                  lines: 3,
                                  spacing: 6,
                                  lineStyle: SkeletonLineStyle(
                                    randomLength: true,
                                    height: 10,
                                    borderRadius: BorderRadius.circular(2),
                                    minLength:
                                        MediaQuery.of(context).size.width / 2,
                                  )),
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                        width: 50, height: 50)),
                                SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                        width: 50, height: 50)),
                                SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                        width: 50, height: 50)),
                                SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                        width: 50, height: 50)),
                              ],
                            )
                          ],
                        )),
                      );
                    })),
                FutureBuilder(
                    future: NFTCollectionAPI()
                        .getNFTCollectionNFTsBySlug(widget.slug),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        final nfts = snapshot.data as List<NFTModel>;
                        return Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: NFTCollectionNFTItemsGridTab(nftItems: nfts),
                        );
                      }
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                      borderRadius: BorderRadius.circular(30),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  child: SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                      borderRadius: BorderRadius.circular(30),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                      borderRadius: BorderRadius.circular(30),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  child: SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                      borderRadius: BorderRadius.circular(30),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
