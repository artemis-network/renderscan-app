import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/screen/home/components/heading_widget.dart';

import 'package:renderscan/screen/home/home_mock.dart';

import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/components/topbar/topbar.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';

import 'package:renderscan/screen/home/components/showcase_widget.dart';
import 'package:renderscan/screen/home/components/trending_widget.dart';
import 'package:renderscan/screen/home/components/unique_nft_widget.dart';
import 'package:renderscan/screen/home/components/notable_collection_widget.dart';
import 'package:renderscan/screen/home/home_screen_api.dart';
import 'package:renderscan/screen/home/models/trending_model.dart';

import 'package:renderscan/screen/ranking/ranking_screen.dart';
import 'package:renderscan/screen/home/components/home_banners.dart';

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
                child: FutureBuilder(
                  future: HomeScreenApi().getTrendingCollections(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<Trending> trending =
                          snapshot.data as List<Trending>;
                      log.i(trending.length);
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: trending.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TrendingWidget(
                            rank: index + 1,
                            name: trending[index].name ?? "",
                            price: trending[index].oneDayVolume ?? "",
                            url: trending[index].logo ?? "",
                            slug: trending[index].slug ?? "",
                          );
                        },
                      );
                    }
                    return Text("LOADING");
                  },
                ),
              ),
              HomeBanner(),
              HeadingWidget(text: "Showcase"),
              Container(
                height: 120,
                width: 225,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: ShowcaseWidget(
                        id: index,
                        url: mintNowMock[index]["url"].toString(),
                        name: mintNowMock[index]["name"]
                                .toString()
                                .substring(0, 10) +
                            "...",
                        price: 2,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              HeadingWidget(text: "Notable Collections"),
              Container(
                  height: 150,
                  width: 225,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: liveDropsMock.length,
                    itemBuilder: (BuildContext context, int index) {
                      return NotableCollectionWidget(
                        id: index.toString(),
                        banner: liveDropsMock[index]["banner"].toString(),
                        collectionName:
                            liveDropsMock[index]["collectionName"].toString(),
                        name: liveDropsMock[index]["name"].toString(),
                        url: liveDropsMock[index]["url"].toString(),
                      );
                    },
                  )),
              SizedBox(
                height: 30,
              ),
              HeadingWidget(text: "Solona Items"),
              Container(
                  height: 200,
                  width: 225,
                  child: ListView.builder(
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
