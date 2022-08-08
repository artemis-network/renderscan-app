import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/loader.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/common/components/topbar/topbar.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/static_screen/nfts/components/gallery.dart';
import 'package:renderscan/static_screen/nfts/components/nft_tag_row.dart';
import 'package:renderscan/static_screen/nfts/nft_api.dart';

class NFTSScreen extends StatefulWidget {
  @override
  State<NFTSScreen> createState() => _NFTSScreenState();
}

class _NFTSScreenState extends State<NFTSScreen> {
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
              SizedBox(
                height: 20,
              ),
              Container(
                child: FutureBuilder(
                    future: Storage().getItem("username"),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        final username = snapshot.data as String;
                        var url =
                            "https://renderscan-user-avatars.s3.ap-south-1.amazonaws.com/" +
                                username +
                                '.png';
                        return CircleAvatar(
                          backgroundImage: NetworkImage(url),
                          radius: 48,
                        );
                      }
                      return CircleAvatar(
                        backgroundImage: AssetImage("assets/images/lion.png"),
                        radius: 48,
                      );
                    })),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Text(
                      "Admin",
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
              FutureBuilder(
                  future: NFTApi().getGallery(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      final urls = snapshot.data as List<String>;
                      return Expanded(
                        child: NFTGalleryGrid(images: urls),
                      );
                    }
                    return Container(
                        alignment: Alignment.center, child: spinkit);
                  }))
            ],
          )),
    );
  }
}
