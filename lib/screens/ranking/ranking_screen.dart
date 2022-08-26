import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/loader.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/home/home_provider.dart';
import 'package:renderscan/screens/home/models/trending_model.dart';
import 'package:renderscan/screens/ranking/components/ranking_item.dart';
import 'package:renderscan/theme/theme_provider.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({Key? key}) : super(key: key);

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  @override
  Widget build(BuildContext context) {
    showModal(context) {
      final size = MediaQuery.of(context).size;
      return showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: context.watch<ThemeProvider>().getBackgroundColor(),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Filter",
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                          24,
                          FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: size.width * 1,
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                    color: context.watch<ThemeProvider>().getBackgroundColor(),
                    child: Text(
                      "Sort by",
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                          18,
                          FontWeight.bold),
                    ),
                  ),
                  RankSortByTimeFrame(),
                  Container(
                    width: size.width * 1,
                    padding: EdgeInsets.fromLTRB(20, 22, 20, 0),
                    color: context.watch<ThemeProvider>().getBackgroundColor(),
                    child: Text(
                      "Filter by",
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                          18,
                          FontWeight.bold),
                    ),
                  ),
                  RankFliterByCategory()
                ],
              ),
              color: context.watch<ThemeProvider>().getBackgroundColor(),
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Padding(
              child: Image.asset(
                "assets/icons/back.png",
                height: 24,
                width: 24,
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
          ),
        ),
        body: Container(
          color: context.watch<ThemeProvider>().getBackgroundColor(),
          child: Column(
            children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Ranking 🏆",
                          style: kPrimartFont(
                              context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
                              20,
                              FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: context
                                .watch<ThemeProvider>()
                                .getBackgroundColor(),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 0,
                                  blurRadius: 100,
                                  color: context
                                      .watch<ThemeProvider>()
                                      .getHighLightColor()
                                      .withOpacity(0.66),
                                  offset: Offset(0, 0)),
                            ]),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          child: Container(),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        ),
                      ),
                      IconButton(
                          onPressed: () => showModal(context),
                          icon: Icon(
                            Icons.menu_outlined,
                            size: 30,
                            color: context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                          ))
                    ],
                  )),
              Expanded(
                  child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: FutureBuilder(
                    future: context.watch<HomeProvider>().sortByTrending,
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          context.watch<HomeProvider>().sortByTrendingLoaded) {
                        final trending = snapshot.data as List<TrendingModel>;
                        return ListView.builder(
                            cacheExtent: 9999,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: trending.length,
                            itemBuilder: (context, index) {
                              getChange() {
                                final change = context
                                    .watch<HomeProvider>()
                                    .currentTrendingrankingSortByTime;
                                if (change == "daily")
                                  return trending[index].oneDayChange;
                                if (change == "weekly")
                                  return trending[index].sevenDayChange;
                                if (change == "monthly")
                                  return trending[index].thirtyDayChange;
                                return "";
                              }

                              return RankingItem(
                                  slug: trending[index].slug,
                                  ranking: (index + 1).toString(),
                                  url: trending[index].logo.toString(),
                                  name: trending[index].name.toString().length <
                                          12
                                      ? trending[index].name.toString()
                                      : trending[index]
                                              .name
                                              .toString()
                                              .substring(0, 12) +
                                          "...",
                                  change: getChange(),
                                  totalValue: trending[index]
                                              .oneDayVolume
                                              .toString()
                                              .length <
                                          7
                                      ? trending[index].oneDayVolume.toString()
                                      : trending[index]
                                          .oneDayVolume
                                          .toString()
                                          .substring(0, 7),
                                  owners: trending[index].numOwners.toString(),
                                  volume: trending[index].floor.toString());
                            });
                      }
                      return Container(
                        child: spinkit(),
                        alignment: Alignment.center,
                      );
                    },
                  ),
                ),
              ))
            ],
          ),
        ));
  }
}

class RankSortByTimeFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 5 / 2,
          children: [
            RankSortByTag(
              text: "Daily",
              exec: () =>
                  context.read<HomeProvider>().rankingSortByTimeFun("daily"),
            ),
            RankSortByTag(
              text: "Weekly",
              exec: () =>
                  context.read<HomeProvider>().rankingSortByTimeFun("weekly"),
            ),
            RankSortByTag(
              text: "Monthly",
              exec: () =>
                  context.read<HomeProvider>().rankingSortByTimeFun("monthly"),
            ),
          ],
        ));
  }
}

class RankFliterByCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 225,
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 5 / 2,
          children: [
            RankSortByTag(
              text: "New",
              exec: () => context.read<HomeProvider>().filterByCategory("new"),
            ),
            RankSortByTag(
              text: "Art",
              exec: () => context.read<HomeProvider>().filterByCategory("art"),
            ),
            RankSortByTag(
              text: "Collectibles",
              exec: () =>
                  context.read<HomeProvider>().filterByCategory("collectibles"),
            ),
            RankSortByTag(
              text: "Domains",
              exec: () =>
                  context.read<HomeProvider>().filterByCategory("domain-names"),
            ),
            RankSortByTag(
              text: "Music",
              exec: () =>
                  context.read<HomeProvider>().filterByCategory("music"),
            ),
            RankSortByTag(
              text: "Photography",
              exec: () => context
                  .read<HomeProvider>()
                  .filterByCategory("photography-category"),
            ),
            RankSortByTag(
              text: "Sports",
              exec: () =>
                  context.read<HomeProvider>().filterByCategory("sports"),
            ),
            RankSortByTag(
              text: "Trading Cards",
              exec: () => context
                  .read<HomeProvider>()
                  .filterByCategory("trading-cards"),
            ),
            RankSortByTag(
              text: "Utility",
              exec: () =>
                  context.read<HomeProvider>().filterByCategory("utility"),
            ),
          ],
        ));
  }
}

class RankSortByTag extends StatelessWidget {
  final String text;
  final Function exec;

  RankSortByTag({required this.text, required this.exec}) {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        exec();
        Navigator.of(context).pop();
      },
      child: Container(
          height: 20,
          width: 50,
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Text(
            text,
            style: kPrimartFont(
                context.watch<ThemeProvider>().getBackgroundColor(),
                12,
                FontWeight.bold),
          ),
          decoration: BoxDecoration(
            color: context.watch<ThemeProvider>().getPriamryFontColor(),
            borderRadius: BorderRadius.circular(15),
          )),
    );
  }
}
