import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/components/topbar/topbar.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/static_screen/home/components/heading_widget.dart';
import 'package:renderscan/static_screen/home/components/home_banners.dart';

import 'package:renderscan/static_screen/home/components/notable_collection_widget.dart';
import 'package:renderscan/static_screen/home/components/showcase_widget.dart';
import 'package:renderscan/static_screen/home/components/trending_widget.dart';
import 'package:renderscan/static_screen/home/components/unique_nft_widget.dart';
import 'package:renderscan/static_screen/home/home_mock.dart';
import 'package:renderscan/static_screen/home/home_provider.dart';
import 'package:renderscan/transistion_screen/ranking/ranking_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: Drawer(child: SideBar()),
      body: Container(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Topbar(
                popSideBar: () => scaffoldKey.currentState?.openDrawer(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeadingWidget(text: "Trending"),
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RankingScreen()));
                        },
                        icon: Icon(Icons.arrow_forward_rounded,
                            color: context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            size: 24)),
                  )
                ],
              ),
              Container(
                  height: 165,
                  width: 225,
                  child: context.watch<HomeProvider>().trendingLoaded
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              context.watch<HomeProvider>().trending.length,
                          itemBuilder: (BuildContext context, int index) {
                            return TrendingWidget(
                                trending: context
                                    .watch<HomeProvider>()
                                    .trending[index],
                                index: index);
                          },
                        )
                      : Container(
                          child: CircularProgressIndicator(),
                          height: 60,
                          width: 60,
                          alignment: Alignment.center,
                        )),
              HomeBanner(),
              HeadingWidget(text: "Showcase"),
              Container(
                  height: 145,
                  width: 225,
                  child: context.watch<HomeProvider>().showcaseLoaded
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              context.watch<HomeProvider>().showcase.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: ShowcaseWidget(
                                nftdto: context
                                    .watch<HomeProvider>()
                                    .showcase[index],
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                            );
                          },
                        )
                      : Container(
                          height: 60,
                          width: 60,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator())),
              HeadingWidget(text: "Notable Collections"),
              Container(
                  height: 150,
                  width: 225,
                  child: context.watch<HomeProvider>().collectionsLoaded
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              context.watch<HomeProvider>().collections.length,
                          itemBuilder: (BuildContext context, int index) {
                            return NotableCollectionWidget(
                              notableCollection: context
                                  .watch<HomeProvider>()
                                  .collections[index],
                            );
                          },
                        )
                      : Container(
                          height: 60,
                          width: 60,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        )),
              SizedBox(
                height: 30,
              ),
              HeadingWidget(text: "Solona Items"),
              Container(
                  height: 200,
                  width: 225,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: mintNowMock.length,
                    itemBuilder: (BuildContext context, int index) {
                      return UniqueNFTWidget(
                        id: index,
                        url: mintNowMock[index]["url"].toString(),
                        name: mintNowMock[index]["name"]
                                .toString()
                                .substring(0, 10) +
                            "...",
                        price: 2,
                      );
                    },
                  )),
              SizedBox(
                height: 20,
              )
            ],
          ),
          color: context.watch<ThemeProvider>().getBackgroundColor()),
    );
  }
}
