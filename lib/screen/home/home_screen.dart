import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/common/theme/theme_provider.dart';

import 'package:renderscan/screen/home/components/showcase_widget.dart';
import 'package:renderscan/screen/home/components/trending_widget.dart';
import 'package:renderscan/screen/home/components/notable_collection_widget.dart';
import 'package:renderscan/common/components/topbar/topbar.dart';
import 'package:renderscan/screen/home/components/unique_nft_widget.dart';
import 'package:renderscan/screen/home/home_mock.dart';
import 'package:renderscan/screen/ranking/ranking_screen.dart';

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
                  Heading(text: "Trending"),
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
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: topMoversMock.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TrendingWidget(
                      rank: int.parse(topMoversMock[index]["rank"].toString()),
                      name: topMoversMock[index]["name"].toString(),
                      price: double.parse(
                          topMoversMock[index]["price"].toString()),
                      url: topMoversMock[index]["url"].toString(),
                    );
                  },
                ),
              ),
              Banner(),
              Heading(text: "Showcase"),
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
              Heading(text: "Notable Collections"),
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
              Heading(text: "Solona Items"),
              RowWrapper(
                  child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: mintNowMock.length,
                itemBuilder: (BuildContext context, int index) {
                  return UniqueNFTWidget(
                    id: index,
                    url: mintNowMock[index]["url"].toString(),
                    name:
                        mintNowMock[index]["name"].toString().substring(0, 10) +
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

class Heading extends StatelessWidget {
  final String text;
  Heading({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 15, 0, 15),
      child: Text(
        text,
        style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: context.watch<ThemeProvider>().getPriamryFontColor()),
      ),
    );
  }
}

class RowWrapper extends StatelessWidget {
  final Widget child;
  RowWrapper({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(height: 200, width: 225, child: child);
  }
}

class Banner extends StatefulWidget {
  @override
  State<Banner> createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  @override
  Widget build(BuildContext context) {
    final banners = [
      "assets/images/banner_one.png",
      "assets/images/banner_two.png",
      "assets/images/banner_three.png",
    ];
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 130,
      width: 350,
      child: PageView.builder(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: PageController(viewportFraction: 1, initialPage: 0),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Image.asset(
              banners[index],
              width: 130,
              fit: BoxFit.fitHeight,
            );
          }),
    );
  }
}
