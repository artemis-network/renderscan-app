import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/balance_widet.dart';

import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/home/components/heading_widget.dart';
import 'package:renderscan/screens/home/components/home_banners.dart';
import 'package:renderscan/screens/home/components/notable_collection_widget.dart';
import 'package:renderscan/screens/home/components/showcase_widget.dart';
import 'package:renderscan/screens/home/components/trending_widget.dart';
import 'package:renderscan/screens/home/home_provider.dart';
import 'package:renderscan/screens/navigation/notification_api.dart';
import 'package:renderscan/screens/ranking/ranking_screen.dart';
import 'package:renderscan/theme/theme_provider.dart';
import 'package:skeletons/skeletons.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double blurRadius = 3;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  notificationModal(NotificationC notification) async {
    await Future.delayed(Duration(microseconds: 1));
    showDialog(
        context: context,
        builder: (context) {
          final size = MediaQuery.of(context).size;
          return Dialog(
            child: Container(
              color: context.watch<ThemeProvider>().getBackgroundColor(),
              height: size.height * 0.6,
              width: size.width * 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Notification",
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        24,
                        FontWeight.bold),
                  ),
                  Image.asset(
                    "assets/images/lion.png",
                    fit: BoxFit.fill,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        blurRadius = 15;
                      });
                      Future.delayed(
                          Duration(milliseconds: 500),
                          () => {
                                NotificationApi()
                                    .closeNotification()
                                    .then((value) {
                                  Navigator.of(context).pop();
                                })
                              });
                    },
                    child: AnimatedContainer(
                        duration: Duration(milliseconds: 600),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: blurRadius,
                                  color: context
                                      .watch<ThemeProvider>()
                                      .getHighLightColor())
                            ],
                            color: context
                                .watch<ThemeProvider>()
                                .getBackgroundColor()),
                        child: Text(
                          notification.notification,
                          style: kPrimartFont(
                              context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
                              24,
                              FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: NotificationApi().getNotification(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final NotificationC notification = snapshot.data as NotificationC;
          if (notification.hasNotification) {
            notificationModal(notification);
          }
        }
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [BalanceWidget()],
            ),
            backgroundColor:
                context.watch<ThemeProvider>().getBackgroundColor(),
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
          drawerEnableOpenDragGesture: false,
          drawer: Drawer(child: SideBar()),
          body: Container(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HeadingWidget(text: "🔥 Trending"),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RankingScreen()));
                            },
                            icon: Icon(Icons.arrow_forward_ios,
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
                              cacheExtent: 9999,
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
                              height: 165,
                              width: 225,
                              margin: EdgeInsets.only(left: 20),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          width: 96,
                                          height: 96),
                                    ),
                                    SizedBox(width: 24),
                                    SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          width: 96,
                                          height: 96),
                                    ),
                                    SizedBox(width: 24),
                                    SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          width: 96,
                                          height: 96),
                                    ),
                                  ]),
                              alignment: Alignment.center,
                            )),
                  HomeBanner(),
                  HeadingWithIconWidget(
                    text: "Ethereum",
                    icon: CryptoFontIcons.ETC,
                  ),
                  Container(
                      height: 145,
                      width: 225,
                      child: context.watch<HomeProvider>().showcaseLoaded
                          ? ListView.builder(
                              cacheExtent: 9999,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  context.watch<HomeProvider>().showcase.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  child: ShowcaseWidget(
                                    nft: context
                                        .watch<HomeProvider>()
                                        .showcase[index],
                                    chain: CHAIN.eth,
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                );
                              },
                            )
                          : Container(
                              height: 145,
                              width: 225,
                              alignment: Alignment.center,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          width: 96,
                                          height: 96),
                                    ),
                                    SizedBox(width: 24),
                                    SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          width: 96,
                                          height: 96),
                                    ),
                                    SizedBox(width: 24),
                                    SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          width: 96,
                                          height: 96),
                                    ),
                                  ]),
                            )),
                  HeadingWidget(text: "🎖️ Notable Collections"),
                  Container(
                      height: 150,
                      width: 225,
                      child: context.watch<HomeProvider>().collectionsLoaded
                          ? ListView.builder(
                              cacheExtent: 9999,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: context
                                  .watch<HomeProvider>()
                                  .collections
                                  .length,
                              itemBuilder: (BuildContext context, int index) {
                                return NotableCollectionWidget(
                                  notableCollection: context
                                      .watch<HomeProvider>()
                                      .collections[index],
                                );
                              },
                            )
                          : Container(
                              height: 150,
                              width: 225,
                              alignment: Alignment.center,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          width: 136,
                                          height: 116),
                                    ),
                                    SizedBox(width: 24),
                                    SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          width: 136,
                                          height: 116),
                                    ),
                                  ]),
                            )),
                  HeadingWithImageWidget(
                    text: "Solana NFTs",
                    image: "assets/images/sol.png",
                  ),
                  Container(
                      height: 145,
                      width: 225,
                      child: context.watch<HomeProvider>().solanaNFTsLoaded
                          ? ListView.builder(
                              cacheExtent: 9999,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: context
                                  .watch<HomeProvider>()
                                  .solanaNFts
                                  .length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  child: ShowcaseWidget(
                                    nft: context
                                        .watch<HomeProvider>()
                                        .solanaNFts[index],
                                    chain: CHAIN.solana,
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                );
                              },
                            )
                          : Container(
                              height: 145,
                              width: 225,
                              alignment: Alignment.center,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          width: 96,
                                          height: 96),
                                    ),
                                    SizedBox(width: 24),
                                    SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          width: 96,
                                          height: 96),
                                    ),
                                    SizedBox(width: 24),
                                    SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          width: 96,
                                          height: 96),
                                    ),
                                  ]),
                            )),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
              color: context.watch<ThemeProvider>().getBackgroundColor()),
        );
      },
    );
  }
}
