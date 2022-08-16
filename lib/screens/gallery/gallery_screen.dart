import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/loader.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/common/components/topbar/topbar.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/gallery/components/gallery_grid.dart';
import 'package:renderscan/screens/gallery/components/gallery_tags_row.dart';
import 'package:renderscan/screens/gallery/gallery_api.dart';

class GalleryScreen extends StatefulWidget {
  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      "assets/avtars/1.png",
      "assets/avtars/2.png",
      "assets/avtars/3.png",
      "assets/avtars/4.png",
      "assets/avtars/5.png",
      "assets/avtars/6.png",
      "assets/avtars/7.png",
      "assets/avtars/8.png",
      "assets/avtars/9.png",
      "assets/avtars/10.png",
    ];

    final random = new Random().nextInt(11);

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
                        backgroundImage: AssetImage(images[random]),
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
              GalleryTagRow(),
              FutureBuilder(
                  future: GalleryApi().getGallery(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      final urls = snapshot.data as List<String>;
                      return Expanded(
                        child: GalleryGrid(images: urls),
                      );
                    }
                    return Container(
                        alignment: Alignment.center, child: spinkit());
                  }))
            ],
          )),
    );
  }
}
