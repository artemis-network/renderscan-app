import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/filters/auth_filter.dart';
import 'package:renderscan/common/components/topbar/components/sidebar_button.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/faq/faq_screen.dart';
import 'package:renderscan/screens/feedback/feedback_screen.dart';
import 'package:renderscan/screens/login/login_screen.dart';
import 'package:renderscan/screens/navigation/navigation_provider.dart';
import 'package:renderscan/screens/navigation/navigation_screen.dart';
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

    final size = MediaQuery.of(context).size;
    bool isMusicOn = context.watch<ThemeProvider>().IsMusic();
    return Container(
      constraints: BoxConstraints(minHeight: size.height),
      color: context.watch<ThemeProvider>().getBackgroundColor(),
      padding: EdgeInsets.only(top: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              "Welcome",
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
                                    "Guest!",
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
                                    AssetImage("assets/avtars/1.png"),
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
                    icon: "assets/icons/account.png",
                    onClick: () {
                      context.read<NavigationProvider>().setCurrentIndex(4);
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return NavigationScreen();
                      }));
                    }),
                SideBarButton(
                  text: "Transactions",
                  icon: "assets/icons/transactions.png",
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
                  icon: "assets/icons/refer.png",
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
                  icon: "assets/icons/buy.png",
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
                  icon: "assets/icons/feedback.png",
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
                  icon: "assets/icons/faq.png",
                  onClick: () {
                    operate() {
                      return Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return FAQScreen();
                        },
                      ));
                    }

                    operatePage(operate);
                  },
                ),
                SideBarButton(
                  text: "Rate Us",
                  icon: "assets/icons/rateus.png",
                  onClick: () {},
                ),
                AuthFilter(
                    screen: SideBarButton(
                      text: "Logout",
                      icon: "assets/icons/logout.png",
                      onClick: () {
                        print("> Logging out");
                        Storage().logout();
                        context.read<NavigationProvider>().setCurrentIndex(0);
                        context.read<ScanProvider>().resetProvider();
                        Navigator.of(context).pop();
                      },
                    ),
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
                          text: "Login",
                          icon: "assets/icons/logout.png",
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
            Divider(
                height: 8,
                color: context
                    .watch<ThemeProvider>()
                    .getPriamryFontColor()
                    .withOpacity(0.33),
                thickness: 1,
                indent: 1),
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
                            value: isMusicOn,
                            onChanged: (r) {
                              context.read<ThemeProvider>().toggleMusic();
                              setState(() {
                                isMusicOn =
                                    context.watch<ThemeProvider>().IsMusic();
                              });
                            })
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
            ),
          ],
        ),
      ),
    );
  }
}
