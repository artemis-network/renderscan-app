import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/filters/auth_filter.dart';
import 'package:renderscan/common/components/topbar/components/sidebar_button.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/feedback/feedback_screen.dart';
import 'package:renderscan/screens/login/login_screen.dart';
import 'package:renderscan/screens/navigation/navigation_provider.dart';
import 'package:renderscan/screens/referal/referal_screen.dart';
import 'package:renderscan/screens/scan/scan_provider.dart';
import 'package:renderscan/screens/transcations/components/buy_ruby_modal.dart';
import 'package:renderscan/screens/transcations/transaction_screen.dart';
import 'package:renderscan/theme/theme_provider.dart';
import 'package:renderscan/utils/storage.dart';

class SideBar extends StatefulWidget {
  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  AudioPlayer player = AudioPlayer();
  final String audioasset = "assets/audio/music.mp3";

  void loadMusic() async {
    ByteData bytes = await rootBundle.load(audioasset); //load audio from assets
    Uint8List audiobytes =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    if (context.watch<ThemeProvider>().IsMusic()) {
      await player.playBytes(audiobytes);
    } else {
      await player.stop();
    }
  }

  @override
  void initState() {
    loadMusic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    operatePage(Function fn) async {
      final bool isUserLoggedIn = await Storage().isLoggedIn();
      if (isUserLoggedIn) {
        fn();
      } else
        Navigator.of(context).push(PageTransition(
            type: PageTransitionType.bottomToTop,
            child: LoginScreen(),
            ctx: context,
            fullscreenDialog: true,
            duration: Duration(milliseconds: 300),
            childCurrent: SideBar()));
    }

    return Container(
      color: context.watch<ThemeProvider>().getBackgroundColor(),
      padding: EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome ",
                            style: kPrimartFont(
                                context
                                    .watch<ThemeProvider>()
                                    .getPriamryFontColor(),
                                18,
                                FontWeight.bold),
                          ),
                          FutureBuilder(
                              future: Storage().getItem("username"),
                              builder: ((context, snapshot) {
                                final String username =
                                    (snapshot.data ?? "") as String;
                                if (snapshot.hasData) {
                                  return Text(
                                    username + "!",
                                    style: kPrimartFont(
                                        context
                                            .watch<ThemeProvider>()
                                            .getPriamryFontColor(),
                                        18,
                                        FontWeight.bold),
                                  );
                                }
                                return Text(
                                  "User",
                                  style: kPrimartFont(
                                      context
                                          .watch<ThemeProvider>()
                                          .getPriamryFontColor(),
                                      18,
                                      FontWeight.bold),
                                );
                              })),
                        ],
                      ),
                      FutureBuilder(
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
                                radius: 42,
                              );
                            }
                            return CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/lion.png"),
                              radius: 42,
                            );
                          })),
                    ],
                  )),
              Divider(
                  height: 8,
                  color: context
                      .watch<ThemeProvider>()
                      .getPriamryFontColor()
                      .withOpacity(0.33),
                  thickness: 1,
                  indent: 1),
              SideBarButton(
                  text: "Account",
                  icon: Icons.person_rounded,
                  onClick: () {
                    Navigator.of(context).pop();
                    context.read<NavigationProvider>().currentIndex(4);
                  }),
              SideBarButton(
                text: "Transcations",
                icon: Icons.monetization_on_rounded,
                onClick: () {
                  operate() {
                    return Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return TransactionScreen();
                      },
                    ));
                  }

                  operatePage(operate);
                },
              ),
              SideBarButton(
                text: "Refer & Earn",
                icon: Icons.money_outlined,
                onClick: () {
                  operate() {
                    return Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return ReferalScreen();
                      },
                    ));
                  }

                  operatePage(operate);
                },
              ),
              Divider(
                  height: 8,
                  color: context
                      .watch<ThemeProvider>()
                      .getPriamryFontColor()
                      .withOpacity(0.33),
                  thickness: 1,
                  indent: 1),
              SideBarButton(
                text: "Buy Ruby",
                icon: Icons.money_outlined,
                onClick: () {
                  Navigator.of(context).push(PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: BuyRubyModal(),
                      ctx: context,
                      duration: Duration(milliseconds: 300),
                      fullscreenDialog: true,
                      childCurrent: SideBar()));
                },
              ),
              Divider(
                  height: 8,
                  color: context
                      .watch<ThemeProvider>()
                      .getPriamryFontColor()
                      .withOpacity(0.33),
                  thickness: 1,
                  indent: 1),
              SideBarButton(
                text: "Feedback",
                icon: Icons.feedback_outlined,
                onClick: () {
                  operate() {
                    return Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return FeedbackScreen();
                      },
                    ));
                  }

                  operatePage(operate);
                },
              ),
              SideBarButton(
                text: "Terms of use",
                icon: Icons.feedback_outlined,
                onClick: () {
                  operate() {
                    return Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return FeedbackScreen();
                      },
                    ));
                  }

                  operatePage(operate);
                },
              ),
              SideBarButton(
                text: "FAQ",
                icon: Icons.feedback_outlined,
                onClick: () {
                  operate() {
                    return Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return FeedbackScreen();
                      },
                    ));
                  }

                  operatePage(operate);
                },
              ),
              SideBarButton(
                text: "Rate Us",
                icon: Icons.star_outlined,
                onClick: () {},
              ),
              AuthFilter(
                  screen: SideBarButton(
                    text: "Logout",
                    icon: Icons.logout_outlined,
                    onClick: () {
                      print("> Logging out");
                      Storage().logout();
                      context.read<NavigationProvider>().setCurrentIndex(0);
                      context.read<ScanProvider>().resetProvider();
                      Navigator.of(context).pop();
                    },
                  ),
                  guestView: Container()),
              AuthFilter(
                  screen: Container(),
                  guestView: Column(
                    children: [
                      Divider(
                          height: 8,
                          color: context
                              .watch<ThemeProvider>()
                              .getPriamryFontColor()
                              .withOpacity(0.33),
                          thickness: 1,
                          indent: 1),
                      SideBarButton(
                        text: "Login in",
                        icon: Icons.logout_outlined,
                        onClick: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: ((context) {
                            return LoginScreen();
                          })));
                        },
                      )
                    ],
                  ))
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Music",
                        style: kPrimartFont(
                            context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            12,
                            FontWeight.bold),
                      ),
                      Switch(
                          value: context.watch<ThemeProvider>().IsMusic(),
                          onChanged: (r) async {})
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Dark Theme",
                        style: kPrimartFont(
                            context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            12,
                            FontWeight.bold),
                      ),
                      Switch(
                          value: context.watch<ThemeProvider>().isDarkTheme(),
                          onChanged: (r) {
                            context.read<ThemeProvider>().setTheme(r);
                          })
                    ],
                  )
                ]),
          )
        ],
      ),
    );
  }
}
