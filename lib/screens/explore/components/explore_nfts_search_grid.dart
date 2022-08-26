import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/explore/components/nft_grid.dart';
import 'package:renderscan/screens/home/home_provider.dart';
import 'package:renderscan/screens/home/models/nfts.model.dart';
import 'package:renderscan/theme/theme_provider.dart';
import 'package:skeletons/skeletons.dart';

class ExploreNFTsSearchGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    loader() {
      return SingleChildScrollView(
        child: Container(
          color: context.watch<ThemeProvider>().getBackgroundColor(),
          height: size.height,
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
          child: Column(
            children: [
              Row(
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
              ),
            ],
          ),
        ),
      );
    }

    return FutureBuilder(
        future: context.watch<HomeProvider>().exploreNFTs,
        builder: ((context, snapshot) {
          if (!context.watch<HomeProvider>().exploreNFTSearchDone)
            return loader();
          if (snapshot.hasData) {
            List<NFTHomeModel> nfts = snapshot.data as List<NFTHomeModel>;
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
          return loader();
        }));
  }
}
