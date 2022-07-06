import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/common/theme/theme_provider.dart';

import 'package:renderscan/screen/home/components/mint_now_row.dart';
import 'package:renderscan/screen/home/components/top_movers_row.dart';
import 'package:renderscan/screen/home/components/live_drop_row.dart';
import 'package:renderscan/common/components/topbar/topbar.dart';
import 'package:renderscan/screen/home/home_mock.dart';

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
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text(
                  "Mint now",
                  style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color:
                          context.watch<ThemeProvider>().getPriamryFontColor()),
                ),
              ),
              Container(
                  height: 205,
                  width: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: mintNowMock.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MintNowItem(
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
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text(
                  "Top Movers",
                  style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color:
                          context.watch<ThemeProvider>().getPriamryFontColor()),
                ),
              ),
              TopMoversRowList(topMovers: topMoversMock),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text(
                  "Live Drops",
                  style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color:
                          context.watch<ThemeProvider>().getPriamryFontColor()),
                ),
              ),
              LiveDropRowList(liveDrops: liveDropsMock),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text(
                  "Unique Items",
                  style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color:
                          context.watch<ThemeProvider>().getPriamryFontColor()),
                ),
              ),
              Container(
                  height: 205,
                  width: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: mintNowMock.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MintNowItem(
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
            ],
          ),
          color: context.watch<ThemeProvider>().getBackgroundColor()),
    );
  }
}
