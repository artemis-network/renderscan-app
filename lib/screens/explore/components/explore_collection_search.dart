import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/explore/components/explore_grid.dart';
import 'package:renderscan/screens/home/home_provider.dart';
import 'package:renderscan/screens/home/models/notable_collection.model.dart';
import 'package:renderscan/theme/theme_provider.dart';
import 'package:skeletons/skeletons.dart';

class ExploreCollectionSearchGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    loader() {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40),
          width: size.width,
          height: size.height,
          color: context.watch<ThemeProvider>().getBackgroundColor(),
          child: Column(
            children: [
              Container(
                child: SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    borderRadius: BorderRadius.circular(30),
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    borderRadius: BorderRadius.circular(30),
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return FutureBuilder(
        future: context.watch<HomeProvider>().exploreCollections,
        builder: ((context, snapshot) {
          if (!context.watch<HomeProvider>().exploreCollectionSearchDone)
            return loader();
          if (snapshot.hasData) {
            final collections = snapshot.data as List<NotableCollectionModel>;
            if (collections.length > 0)
              return ExploreGrid(exploreItems: collections);
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
