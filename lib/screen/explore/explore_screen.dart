import 'package:flutter/material.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/common/components/topbar/topbar.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/explore/components/explore_grid.dart';
import 'package:renderscan/screen/explore/components/search_button.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/screen/explore/explore_mock.dart';
import 'package:renderscan/screen/nfts/components/nft_grid.dart';
import 'package:renderscan/screen/nfts/nfts_mock.dart';

class ExploreScreen extends StatefulWidget {
  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int tabIndex = 0;

  final tabs = [
    NFTGrid(nftItems: nfts),
    ExploreGrid(exploreItems: exploreMock),
  ];

  showModal(context) {
    final size = MediaQuery.of(context).size;
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color:
                          context.watch<ThemeProvider>().getBackgroundColor(),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Filter",
                        style: kPrimartFont(
                            context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            24,
                            FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: size.width * 1,
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                      color:
                          context.watch<ThemeProvider>().getBackgroundColor(),
                      child: Text(
                        "Sort by",
                        style: kPrimartFont(
                            context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            18,
                            FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: size.height * 0.28,
                      child: Expanded(child: ExploreSortByGrid()),
                    ),
                    Container(
                      width: size.width * 1,
                      padding: EdgeInsets.fromLTRB(20, 22, 20, 0),
                      color:
                          context.watch<ThemeProvider>().getBackgroundColor(),
                      child: Text(
                        "Filter by",
                        style: kPrimartFont(
                            context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            18,
                            FontWeight.bold),
                      ),
                    ),
                    Expanded(child: ExploreFliterByGrid())
                  ]),
            ),
            color: context.watch<ThemeProvider>().getBackgroundColor(),
          );
        });
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    getChipBG(int index) {
      return tabIndex == index
          ? context.watch<ThemeProvider>().getHighLightColor()
          : context.watch<ThemeProvider>().getBackgroundColor();
    }

    getChipShadow(int index) {
      return tabIndex == index
          ? context.watch<ThemeProvider>().getBackgroundColor()
          : context.watch<ThemeProvider>().getHighLightColor();
    }

    getChipFontColor(int index) {
      return tabIndex == index
          ? context.watch<ThemeProvider>().getBackgroundColor()
          : context.watch<ThemeProvider>().getPriamryFontColor();
    }

    return Scaffold(
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: Drawer(
        child: SideBar(),
      ),
      body: Column(children: [
        Topbar(
          popSideBar: () => scaffoldKey.currentState?.openDrawer(),
        ),
        Container(
          color: context.watch<ThemeProvider>().getBackgroundColor(),
          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: SearchButton(),
        ),
        Container(
          color: context.watch<ThemeProvider>().getBackgroundColor(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    tabIndex = 0;
                  });
                },
                child: Chip(
                  backgroundColor: getChipBG(0),
                  shadowColor: getChipShadow(0),
                  elevation: 2,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  avatar: Icon(
                    Icons.card_giftcard_outlined,
                    color: getChipFontColor(0),
                  ),
                  label: Text(
                    'NFTs',
                    style:
                        kPrimartFont(getChipFontColor(0), 16, FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    tabIndex = 1;
                  });
                },
                child: Chip(
                  backgroundColor: getChipBG(1),
                  shadowColor: getChipShadow(1),
                  elevation: 2,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  avatar: Icon(
                    Icons.collections_outlined,
                    color: getChipFontColor(1),
                  ),
                  label: Text(
                    'Collections',
                    style:
                        kPrimartFont(getChipFontColor(1), 16, FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: tabs[tabIndex],
        )
      ]),
    );
  }
}

class ExploreSortByGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 5 / 2,
          children: [
            ExploreSortByTag(text: "Low price"),
            ExploreSortByTag(text: "High price"),
            ExploreSortByTag(text: "Low volume"),
            ExploreSortByTag(text: "High volume"),
            ExploreSortByTag(text: "Trending"),
            ExploreSortByTag(text: "Almost sold"),
            ExploreSortByTag(text: "Most Owners"),
            ExploreSortByTag(text: "Few Owners"),
            ExploreSortByTag(text: "Oldest️"),
            ExploreSortByTag(text: "Newest"),
          ],
        ));
  }
}

class ExploreFliterByGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 5 / 2,
          children: [
            ExploreSortByTag(text: "Upcoming"),
            ExploreSortByTag(text: "Sale"),
          ],
        ));
  }
}

class ExploreSortByTag extends StatelessWidget {
  final String text;

  ExploreSortByTag({required this.text}) {}

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
              context.watch<ThemeProvider>().getPriamryFontColor(),
              12,
              FontWeight.bold),
        ),
        decoration: BoxDecoration(
          color: context.watch<ThemeProvider>().getHighLightColor(),
          borderRadius: BorderRadius.circular(15),
        ));
  }
}
