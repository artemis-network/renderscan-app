import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/loader.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/static_screen/home/home_provider.dart';
import 'package:renderscan/static_screen/explore/components/nft_grid.dart';
import 'package:renderscan/static_screen/nfts_collection/models/nft.model.dart';

class ExploreNFTsSearchGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.watch<HomeProvider>().exploreNFTs,
        builder: ((context, snapshot) {
          if (!context.watch<HomeProvider>().exploreNFTSearchDone) {
            return Container(
              alignment: Alignment.center,
              color: context.watch<ThemeProvider>().getBackgroundColor(),
              child: spinkit(),
            );
          }
          if (snapshot.hasData) {
            List<NFTModel> nfts = snapshot.data as List<NFTModel>;
            if (nfts.length > 0)
              return SingleChildScrollView(
                child: NFTGrid(nftItems: nfts),
              );
            else
              return Container(
                alignment: Alignment.center,
                color: context.watch<ThemeProvider>().getBackgroundColor(),
                child: Text(
                  "No Collection found!",
                  style: kPrimartFont(
                      context.watch<ThemeProvider>().getPriamryFontColor(),
                      22,
                      FontWeight.normal),
                ),
              );
          }
          return Container(
            alignment: Alignment.center,
            color: context.watch<ThemeProvider>().getBackgroundColor(),
            child: spinkit(),
          );
        }));
  }
}
