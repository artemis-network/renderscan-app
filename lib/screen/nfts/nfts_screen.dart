import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/common/components/topbar/topbar.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/nfts/components/nft_grid.dart';
import 'package:renderscan/screen/nfts/components/nft_tag_row.dart';
import 'package:renderscan/screen/nfts/nfts_mock.dart';

class NFTSScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: Drawer(
        child: SideBar(),
      ),
      body: Container(
          height: size.height,
          width: size.width,
          color: context.watch<ThemeProvider>().getBackgroundColor(),
          child: Column(
            children: [
              Topbar(
                popSideBar: () => scaffoldKey.currentState?.openDrawer(),
              ),
              Container(
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image.asset(
                          "assets/images/lion.png",
                          height: 100,
                          width: 100,
                        )),
                    Positioned(
                        bottom: 0,
                        child: CircleAvatar(
                          radius: 16,
                          child: IconButton(
                              onPressed: () => {},
                              icon: Icon(
                                Icons.create_outlined,
                                size: 16,
                              )),
                        ))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Text(
                      "Akash Madduru",
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                          18,
                          FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                          color: context
                              .watch<ThemeProvider>()
                              .getBackgroundColor(),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 0,
                                blurRadius: 100,
                                color: context
                                    .watch<ThemeProvider>()
                                    .getHighLightColor()
                                    .withOpacity(0.33),
                                offset: Offset(0, 0))
                          ]),
                      child: Text(
                        "0x318A...adc2",
                        style: kPrimartFont(
                            context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            12,
                            FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              NFTTagRow(),
              Expanded(
                child: NFTGrid(nftItems: nfts),
              )
            ],
          )),
    );
  }
}
