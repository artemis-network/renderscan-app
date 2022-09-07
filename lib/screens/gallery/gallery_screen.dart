import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/balance_widet.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/gallery/components/gallery_grid.dart';
import 'package:renderscan/screens/gallery/components/gallery_tags_row.dart';
import 'package:renderscan/screens/gallery/gallery_api.dart';
import 'package:renderscan/theme/theme_provider.dart';
import 'package:renderscan/utils/logger.dart';
import 'package:renderscan/utils/storage.dart';
import 'package:skeletons/skeletons.dart';

class GalleryScreen extends StatefulWidget {
  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<GalleryModel> gallery = [];
  bool isGalleryLoaded = false;

  loader() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    borderRadius: BorderRadius.circular(30),
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                child: SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    borderRadius: BorderRadius.circular(30),
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    borderRadius: BorderRadius.circular(30),
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                child: SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    borderRadius: BorderRadius.circular(30),
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  List<String> galleryType = [
    "MINTED",
    "SCANNED",
    "IMPORTED",
    "GENERATED",
  ];
  List<bool> activeTab = [true, false, false, false];

  void changePage(int index) {
    var tab = [false, false, false, false];
    tab[index] = true;
    setState(() {
      isGalleryLoaded = false;
      activeTab = tab;
    });
    GalleryApi().getGallery(galleryType[index]).then((value) {
      setState(() {
        gallery = value;
        isGalleryLoaded = true;
      });
    }).catchError((err) {
      setState(() {
        isGalleryLoaded = false;
      });
      log.i(err);
    });
  }

  @override
  void initState() {
    GalleryApi().getGallery("SCANNED").then((value) {
      setState(() {
        gallery = value;
        isGalleryLoaded = true;
      });
    }).catchError((err) {
      setState(() {
        isGalleryLoaded = false;
      });

      log.i(err);
    });
    super.initState();
  }

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
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [BalanceWidget()],
        ),
        backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
        leading: GestureDetector(
          onTap: () {
            scaffoldKey.currentState?.openDrawer();
          },
          child: Padding(
            child: Image.asset(
              "assets/icons/menu.png",
              height: 24,
              width: 24,
            ),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        height: size.height,
        width: size.width,
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              child: FutureBuilder(
                  future: Storage().getItem("username"),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      try {
                        final username = snapshot.data as String;
                        var url =
                            "https://renderscan-user-avatars.s3.ap-south-1.amazonaws.com/" +
                                username +
                                '.png';
                        return CircleAvatar(
                          backgroundImage: NetworkImage(url),
                          radius: 48,
                        );
                      } catch (err) {
                        return CircleAvatar(
                          backgroundImage: AssetImage(images[random]),
                          radius: 48,
                        );
                      }
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
                  FutureBuilder(
                      future: Storage().getItem("username"),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          final username = snapshot.data;
                          return Text(
                            username.toString(),
                            style: kPrimartFont(
                                context
                                    .watch<ThemeProvider>()
                                    .getPriamryFontColor(),
                                18,
                                FontWeight.bold),
                          );
                        }
                        return Text(
                          "",
                          style: kPrimartFont(
                              context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
                              18,
                              FontWeight.bold),
                        );
                      })),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: FutureBuilder(
                        future: Storage().getItem("address"),
                        builder: ((context, snapshot) {
                          if (snapshot.hasData) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: context
                                            .watch<ThemeProvider>()
                                            .getBackgroundColor(),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 0),
                                              blurRadius: 2,
                                              color: context
                                                  .watch<ThemeProvider>()
                                                  .getHighLightColor())
                                        ]),
                                    child: Container(
                                      child: Text(
                                        snapshot.data
                                                .toString()
                                                .substring(0, 5) +
                                            "....." +
                                            snapshot.data.toString().substring(
                                                snapshot.data
                                                        .toString()
                                                        .length -
                                                    6,
                                                snapshot.data
                                                        .toString()
                                                        .length -
                                                    1),
                                        style: kPrimartFont(
                                            context
                                                .watch<ThemeProvider>()
                                                .getPriamryFontColor(),
                                            12,
                                            FontWeight.bold),
                                      ),
                                    )),
                                SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Clipboard.setData(ClipboardData(
                                          text: snapshot.data.toString()));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text("Address copied!")));
                                    },
                                    child: Image.asset(
                                      "assets/icons/copy.png",
                                      height: 16,
                                      width: 16,
                                    ))
                              ],
                            );
                          }
                          return Container();
                        })),
                  ),
                ],
              ),
            ),
            GalleryTagRow(
              activeTab: activeTab,
              click: changePage,
            ),
            isGalleryLoaded
                ? Expanded(
                    child: GalleryGrid(images: gallery),
                  )
                : loader()
          ],
        ),
      )),
    );
  }
}
