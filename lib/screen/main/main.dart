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
    return Scaffold(
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: Drawer(child: SideBar()),
      body: Container(
        child: Flexible(
            child: Column(
          children: [
            Topbar(
              popSideBar: () => scaffoldKey.currentState?.openDrawer(),
            ),
            Flexible(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Text(
                      "Mint now",
                      style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: context
                              .watch<ThemeProvider>()
                              .getPriamryFontColor()),
                    ),
                  ),
                  MintNowRowList(mintNow: mintNow),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Text(
                      "Top Movers",
                      style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: context
                              .watch<ThemeProvider>()
                              .getPriamryFontColor()),
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
                          color: context
                              .watch<ThemeProvider>()
                              .getPriamryFontColor()),
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
                          color: context
                              .watch<ThemeProvider>()
                              .getPriamryFontColor()),
                    ),
                  ),
                  MintNowRowList(
                    mintNow: mintNow,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Text(
                      "Top Wallets",
                      style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: context
                              .watch<ThemeProvider>()
                              .getPriamryFontColor()),
                    ),
                  ),
                  TopMoversRowList(topMovers: topMoversMock),
                ],
              ),
            )
          ],
        )),
        color: context.watch<ThemeProvider>().getBackgroundColor(),
      ),
    );
  }
}
