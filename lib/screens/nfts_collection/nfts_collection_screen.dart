import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/nfts_collection/components/nft_collection_screen_banenr.dart';
import 'package:renderscan/screens/nfts_collection/components/nft_collection_screen_nft_item.dart';
import 'package:renderscan/screens/nfts_collection/components/nft_collection_screen_stats.dart';
import 'package:renderscan/screens/nfts_collection/models/nft.model.dart';
import 'package:renderscan/screens/nfts_collection/models/nft_collection.model.dart';
import 'package:renderscan/screens/nfts_collection/nfts_collection_api.dart';
import 'package:renderscan/theme/theme_provider.dart';
import 'package:renderscan/utils/logger.dart';
import 'package:skeletons/skeletons.dart';

class NFTCollectionScreen extends StatefulWidget {
  final String slug;
  NFTCollectionScreen({required this.slug});

  @override
  State<NFTCollectionScreen> createState() => _NFTCollectionScreenState();
}

class _NFTCollectionScreenState extends State<NFTCollectionScreen> {
  int page = 0;
  late NFTCollectionModel nftCollection;
  bool showDesription = false;
  bool isCollectionLoaded = false;
  bool isNFTsLoaded = false;
  bool isEnded = false;
  List<NFTModel> nfts = [];

  ScrollController _controller = new ScrollController();

  bannerLoader() {
    return SkeletonAvatar(
      style: SkeletonAvatarStyle(
        width: double.infinity,
        minHeight: MediaQuery.of(context).size.height / 8,
        maxHeight: MediaQuery.of(context).size.height / 3,
      ),
    );
  }

  descriptionLoader() {
    return SkeletonParagraph(
      style: SkeletonParagraphStyle(
          lines: 6,
          spacing: 6,
          lineStyle: SkeletonLineStyle(
            randomLength: true,
            height: 10,
            borderRadius: BorderRadius.circular(8),
            minLength: MediaQuery.of(context).size.width / 2,
          )),
    );
  }

  statsLoader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SkeletonAvatar(style: SkeletonAvatarStyle(width: 50, height: 50)),
        SizedBox(width: 15),
        SkeletonAvatar(style: SkeletonAvatarStyle(width: 50, height: 50)),
        SizedBox(width: 15),
        SkeletonAvatar(style: SkeletonAvatarStyle(width: 50, height: 50)),
        SizedBox(width: 15),
        SkeletonAvatar(style: SkeletonAvatarStyle(width: 50, height: 50)),
      ],
    );
  }

  nftLoaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: SkeletonAvatar(
            style: SkeletonAvatarStyle(
              borderRadius: BorderRadius.circular(30),
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.4,
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
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.4,
            ),
          ),
        )
      ],
    );
  }

  nftLoader() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [nftLoader(), nftLoaderRow()],
        ));
  }

  _scrollListener() {
    // // scroll end
    log.i("scrolling");
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      if (isEnded != true && isNFTsLoaded == true) {
        var p = page + 1;
        if (p < 3) {
          setState(() {
            isEnded = false;
          });
          NFTCollectionAPI()
              .getNFTCollectionNFTsBySlug(widget.slug, p)
              .then((value) {
            log.i("api call");
            setState(() {
              nfts = [...nfts, ...value];
              page = p;
              isEnded = true;
            });
          }).catchError((err) {
            log.i("api error");
            log.e(err);
          });
        }
      }
      setState(() {
        isEnded = true;
      });
    }
  }

  @override
  void initState() {
    _controller = ScrollController(
      initialScrollOffset: 0.0, // NEW
      keepScrollOffset: true,
    );
    _controller.addListener(_scrollListener);

    NFTCollectionAPI().getNFTCollectionBySlug(widget.slug).then((value) {
      nftCollection = value;
      isCollectionLoaded = true;
    }).catchError((err) {
      log.e(err);
    });

    NFTCollectionAPI()
        .getNFTCollectionNFTsBySlug(widget.slug, page)
        .then((value) {
      setState(() {
        nfts = value;
        isNFTsLoaded = true;
      });
    }).catchError((err) {
      log.e(err);
    });

    super.initState();
  }

  descriptionFetcher() {
    if (showDesription) {
      return Text(
        nftCollection.description,
        style: kPrimartFont(
            context.watch<ThemeProvider>().getPriamryFontColor(),
            10,
            FontWeight.normal),
      );
    }
    return Text(
      nftCollection.description.length < 150
          ? nftCollection.description
          : nftCollection.description.substring(0, 150) + "...",
      style: kPrimartFont(context.watch<ThemeProvider>().getPriamryFontColor(),
          10, FontWeight.normal),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
          body: SingleChildScrollView(
            controller: _controller,
            child: Column(children: [
              isCollectionLoaded
                  ? NFTCollectScreenBanner(
                      bannerUrl: nftCollection.bannerUrl,
                      imageUrl: nftCollection.imageUrl)
                  : bannerLoader(),
              isCollectionLoaded
                  ? Column(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
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
                      ],
                    )
                  : descriptionLoader(),
              isCollectionLoaded
                  ? NFTCollectionScreenStats(
                      floorPrice: nftCollection.floorPrice.toString(),
                      totalSupply: nftCollection.totalSuppy,
                      owners: nftCollection.owners,
                      volume: nftCollection.totalVolume,
                    )
                  : statsLoader(),
              Divider(thickness: 1),
              isNFTsLoaded
                  ? MasonryGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      shrinkWrap: true,
                      itemCount: nfts.length,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return NFTCollectionScreenNFTItem(
                          nft: nfts[index],
                        );
                      },
                    )
                  : nftLoader(),
              !isEnded
                  ? Container()
                  : Container(
                      margin: EdgeInsets.symmetric(vertical: 40),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                height: 25,
                                width: 25,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                height: 25,
                                width: 25,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                height: 25,
                                width: 25,
                              ),
                            )
                          ])),
            ]),
          )),
    );
  }
}
