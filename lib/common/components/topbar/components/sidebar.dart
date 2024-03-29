import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
import 'package:renderscan/screens/profile/profile_sidebar.dart';
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
  String url =
      "https://renderscan-user-avatars.s3.ap-south-1.amazonaws.com/avatar.png";

  @override
  void initState() {
    Storage().getItem("avatarUrl").then((value) {
      final u = value.toString();
      setState(() {
        url = u;
      });
    });
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

    final size = MediaQuery.of(context).size;
    bool isMusicOn = context.watch<ThemeProvider>().IsMusic();
    return Container(
      constraints: BoxConstraints(minHeight: size.height),
      color: context.watch<ThemeProvider>().getBackgroundColor(),
      padding: EdgeInsets.only(top: 30),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
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
                                    return AutoSizeText(
                                      username + "!",
                                      style: kPrimartFont(
                                          context
                                              .watch<ThemeProvider>()
                                              .getPriamryFontColor(),
                                          18,
                                          FontWeight.bold),
                                    );
                                  }
                                  return AutoSizeText(
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
                        CircleAvatar(
                          backgroundImage: NetworkImage(url),
                          backgroundColor: context
                              .watch<ThemeProvider>()
                              .getFavouriteColor(),
                          radius: 42,
                        ),
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
                      operate() {
                        Navigator.of(context).push(PageTransition(
                            type: PageTransitionType.bottomToTop,
                            child: ProfileSideBarScreen(),
                            ctx: context,
                            duration: Duration(milliseconds: 300),
                            fullscreenDialog: true,
                            childCurrent: SideBar()));
                      }

                      operatePage(operate);
                      ;
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
                    operate() {
                      Navigator.of(context).push(PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: BuyRubyModal(),
                          ctx: context,
                          duration: Duration(milliseconds: 300),
                          fullscreenDialog: true,
                          childCurrent: SideBar()));
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
                  text: "Feedback",
                  icon: "assets/icons/feedback.png",
                  onClick: () {
                    return Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return FeedbackScreen();
                      },
                    ));
                  },
                ),
                SideBarButton(
                  text: "FAQ",
                  icon: "assets/icons/faq.png",
                  onClick: () {
                    return Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return FAQScreen();
                      },
                    ));
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
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                backgroundColor: context
                                    .watch<ThemeProvider>()
                                    .getBackgroundColor(),
                                elevation: 4,
                                child: Container(
                                    height: 250,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: AutoSizeText(
                                            "Logout ",
                                            textAlign: TextAlign.center,
                                            style: kPrimartFont(
                                                context
                                                    .watch<ThemeProvider>()
                                                    .getPriamryFontColor(),
                                                24,
                                                FontWeight.bold),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              FontAwesomeIcons
                                                  .circleExclamation,
                                              size: 20,
                                              color: context
                                                  .watch<ThemeProvider>()
                                                  .getHighLightColor(),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Container(
                                              child: AutoSizeText(
                                                "We'll miss you, Logout now ?",
                                                textAlign: TextAlign.center,
                                                style: kPrimartFont(
                                                    context
                                                        .watch<ThemeProvider>()
                                                        .getPriamryFontColor(),
                                                    18,
                                                    FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                  vertical: 10,
                                                ),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: context
                                                        .watch<ThemeProvider>()
                                                        .getHighLightColor()),
                                                child: AutoSizeText(
                                                  "No",
                                                  style: kPrimartFont(
                                                    context
                                                        .watch<ThemeProvider>()
                                                        .getPriamryFontColor(),
                                                    22,
                                                    FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            GestureDetector(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                  vertical: 10,
                                                ),
                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          blurRadius: 2,
                                                          color: context
                                                              .watch<
                                                                  ThemeProvider>()
                                                              .getHighLightColor())
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: context
                                                        .watch<ThemeProvider>()
                                                        .getBackgroundColor()),
                                                child: AutoSizeText(
                                                  "Yes, Logout",
                                                  style: kPrimartFont(
                                                    context
                                                        .watch<ThemeProvider>()
                                                        .getPriamryFontColor(),
                                                    22,
                                                    FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                GoogleSignIn _googleSignin =
                                                    GoogleSignIn(
                                                  scopes: [
                                                    'email',
                                                    'https://www.googleapis.com/auth/contacts.readonly',
                                                  ],
                                                );
                                                _googleSignin.signOut();
                                                print("> Logging out");
                                                Storage().logout();
                                                context
                                                    .read<NavigationProvider>()
                                                    .setCurrentIndex(0);
                                                context
                                                    .read<ScanProvider>()
                                                    .resetProvider();
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return NavigationScreen();
                                                }));
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    )),
                              );
                            });
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
                        Image.asset(
                          "assets/icons/music.png",
                          height: 16,
                          width: 16,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        AutoSizeText(
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
                        Image.asset(
                          "assets/icons/theme.png",
                          height: 16,
                          width: 16,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        AutoSizeText(
                          "Dark Mode",
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
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
