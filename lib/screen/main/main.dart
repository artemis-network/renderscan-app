import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/common/theme/theme_provider.dart';

import 'package:renderscan/screen/main/components/mint_now_row.dart';
import 'package:renderscan/screen/main/components/top_movers_row.dart';
import 'package:renderscan/screen/main/components/live_drop_row.dart';
import 'package:renderscan/common/components/topbar/topbar.dart';
import 'package:renderscan/screen/main/main_mock.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var mintNow = [
      {
        "url":
            "https://img.seadn.io/files/5251ad011ea118de352859ea21e5e313.png?fit=max&w=600",
        "price": 0.79,
        "name": "devilvalley #3142"
      },
      {
        "url":
            "https://lh3.googleusercontent.com/YNX01FXY5RWUGjNGpXLc171nOiQNcn_e6iwkVfvJOTjiaKFCKupBg48zbL9oPfMzayGjy_eoQcfRrItNjy1lWmdgZuUlv_0Cv6M15rE=w600",
        "price": 7.90,
        "name": "Gazers #146"
      },
      {
        "url":
            "https://img.seadn.io/files/efff3fb1327a406fac3868279fca3477.png?fit=max",
        "price": 1.0,
        "name": "devilvalley #1746"
      },
      {
        "url":
            "https://lh3.googleusercontent.com/YNX01FXY5RWUGjNGpXLc171nOiQNcn_e6iwkVfvJOTjiaKFCKupBg48zbL9oPfMzayGjy_eoQcfRrItNjy1lWmdgZuUlv_0Cv6M15rE=w600",
        "price": 0.20,
        "name": "Dooplicator #537"
      },
      {
        "url":
            "https://img.seadn.io/files/0e8e368780af84218041a8e1649d4411.png?fit=max&w=600",
        "price": 0.40,
        "name": "devilvalley #3989"
      },
      {
        "url":
            "https://img.seadn.io/files/d16bbc12fc129681eba0a7422f07c992.png?fit=max&w=600",
        "price": 0.50,
        "name": "devilvalley #3600"
      },
    ];

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
                    itemCount: mintNow.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MintNowItem(
                        id: index,
                        url: mintNow[index]["url"].toString(),
                        name:
                            mintNow[index]["name"].toString().substring(0, 10) +
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
              LiveDropRowList(liveDrops: liveDrops),
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
                    itemCount: mintNow.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MintNowItem(
                        id: index,
                        url: mintNow[index]["url"].toString(),
                        name:
                            mintNow[index]["name"].toString().substring(0, 10) +
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
