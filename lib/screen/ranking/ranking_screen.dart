import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/common/components/topbar/topbar.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/screen/ranking/components/ranking_item.dart';
import 'package:renderscan/screen/ranking/ranking_mock.dart';
import 'package:renderscan/constants.dart';

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

    var scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            drawerEnableOpenDragGesture: false,
            drawer: Drawer(
              child: SideBar(),
            ),
            body: Container(
              color: context.watch<ThemeProvider>().getBackgroundColor(),
              child: Column(
                children: [
                  Topbar(
                    popSideBar: () => scaffoldKey.currentState?.openDrawer(),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
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
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: rankingMock.length,
                          itemBuilder: (context, index) => RankingItem(
                              ranking: rankingMock[index]['rank'].toString(),
                              url: rankingMock[index]['url'].toString(),
                              name: rankingMock[index]['name'].toString(),
                              floor: rankingMock[index]['floor'].toString(),
                              totalValue:
                                  rankingMock[index]['totalValue'].toString(),
                              owners: rankingMock[index]['owners'].toString(),
                              volume: rankingMock[index]['volume'].toString())),
                    ),
                  ))
                ],
              ),
            )));
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
            RankSortByTag(text: "Daily"),
            RankSortByTag(text: "Weekly"),
            RankSortByTag(text: "Monthly"),
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
            RankSortByTag(text: "Art"),
            RankSortByTag(text: "Collectable"),
            RankSortByTag(text: "Gamified"),
            RankSortByTag(text: "Music"),
            RankSortByTag(text: "Science"),
          ],
        ));
  }
}

class RankSortByTag extends StatelessWidget {
  final String text;

  RankSortByTag({required this.text}) {}

  @override
  Widget build(BuildContext context) {
    return Container(
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
        ));
  }
}
