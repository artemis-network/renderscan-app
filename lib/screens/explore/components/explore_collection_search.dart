import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/loader.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/explore/components/explore_grid.dart';
import 'package:renderscan/screens/home/home_provider.dart';
import 'package:renderscan/screens/home/models/notable_collection.model.dart';
import 'package:renderscan/theme/theme_provider.dart';

class ExploreCollectionSearchGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.watch<HomeProvider>().exploreCollections,
        builder: ((context, snapshot) {
          if (!context.watch<HomeProvider>().exploreCollectionSearchDone) {
            return Container(
              alignment: Alignment.bottomCenter,
              color: context.watch<ThemeProvider>().getBackgroundColor(),
              child: spinkit(),
            );
          }
          if (snapshot.hasData) {
            List<NotableCollectionModel> collections =
                snapshot.data as List<NotableCollectionModel>;
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
          return Container(
            alignment: Alignment.bottomCenter,
            color: context.watch<ThemeProvider>().getBackgroundColor(),
            child: spinkit(),
          );
        }));
  }
}
