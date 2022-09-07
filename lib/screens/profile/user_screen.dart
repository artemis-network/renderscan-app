import 'dart:math';

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/balance_widet.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';

import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/feedback/feedback_screen.dart';
import 'package:renderscan/screens/navigation/navigation_provider.dart';
import 'package:renderscan/screens/navigation/navigation_screen.dart';
import 'package:renderscan/screens/profile/profile_api.dart';
import 'package:renderscan/screens/profile/profile_provider.dart';
import 'package:renderscan/screens/profile/profile_screen.dart';
import 'package:renderscan/screens/scan/scan_provider.dart';
import 'package:renderscan/theme/theme_provider.dart';
import 'package:renderscan/utils/storage.dart';

import 'package:url_launcher/url_launcher.dart';

class UserScreen extends StatefulWidget {
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String displayName = "";
  String language = "";
  String region = "";
  String email = "";
  final String webUrl = "https://www.renderverse.io";

  Future<void> launchPage() async {
    if (await canLaunchUrl(Uri.parse(webUrl))) {
      await launchUrl(Uri.parse(webUrl));
    }
    throw 'Could not launch $webUrl';
  }

  @override
  void initState() {
    ProfileApi().getProfile().then((value) async {
      setState(() {
        displayName = value.displayName;
        language = value.language;
        region = value.region;
        email = value.email;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool allowClose = true;
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
    return Container(
        child: DoubleBack(
            condition: allowClose,
            onConditionFail: () {
              setState(() {
                allowClose = !allowClose;
              });
            },
            child: Scaffold(
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                  ),
                ),
                drawerEnableOpenDragGesture: false,
                drawer: Drawer(child: SideBar()),
                body: Container(
                  color: context.watch<ThemeProvider>().getBackgroundColor(),
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                        decoration: BoxDecoration(
                            color: context
                                .watch<ThemeProvider>()
                                .getBackgroundColor(),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 0,
                                  blurRadius: 100,
                                  color: context
                                      .watch<ThemeProvider>()
                                      .getHighLightColor()
                                      .withOpacity(0.22),
                                  offset: Offset(0, 0)),
                            ]),
                        child: Row(
                          children: [
                            FutureBuilder(
                                future: Storage().getItem("username"),
                                builder: ((context, snapshot) {
                                  if (snapshot.hasData) {
                                    try {
                                      final username = snapshot.data as String;
                                      var url =
                                          "https://renderscan-user-avatars.s3.ap-south-1.amazonaws.com/" +
                                              username +
                                              '.png';
                                      return Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Image.network(
                                            url,
                                            fit: BoxFit.fill,
                                            errorBuilder: (c, e, s) {
                                              return CircleAvatar(
                                                backgroundImage:
                                                    AssetImage(images[random]),
                                                radius: 48,
                                              );
                                            },
                                          ),
                                          Positioned(
                                              right: 0,
                                              bottom: -12,
                                              child: GestureDetector(
                                                child: Image.asset(
                                                  "assets/icons/edit.png",
                                                  height: 46,
                                                  width: 46,
                                                ),
                                                onTap: () {
                                                  Profile profile = Profile(
                                                      displayName: displayName,
                                                      region: region,
                                                      language: language,
                                                      email: email);
                                                  context
                                                      .read<ProfileProvider>()
                                                      .setProfile(profile);
                                                  Navigator.of(context).push(
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .leftToRight,
                                                          child:
                                                              ProfileScreen(),
                                                          ctx: context,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  300),
                                                          fullscreenDialog:
                                                              true,
                                                          childCurrent:
                                                              UserScreen()));
                                                },
                                              ))
                                        ],
                                      );
                                    } catch (e) {
                                      return CircleAvatar(
                                        backgroundImage:
                                            AssetImage(images[random]),
                                        radius: 48,
                                      );
                                    }
                                  }
                                  return CircleAvatar(
                                    backgroundImage: AssetImage(images[random]),
                                    radius: 48,
                                  );
                                })),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    displayName,
                                    style: kPrimartFont(
                                        context
                                            .watch<ThemeProvider>()
                                            .getPriamryFontColor(),
                                        18,
                                        FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  FutureBuilder(
                                      future: Storage().getItem('username'),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            "@" + snapshot.data.toString(),
                                            style: kPrimartFont(
                                                context
                                                    .watch<ThemeProvider>()
                                                    .getSecondaryFontColor(),
                                                16,
                                                FontWeight.normal),
                                          );
                                        }
                                        return Container();
                                      }),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  FutureBuilder(
                                      future: Storage().getItem("address"),
                                      builder: ((context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Row(
                                            children: [
                                              Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: context
                                                          .watch<
                                                              ThemeProvider>()
                                                          .getBackgroundColor(),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            offset:
                                                                Offset(0, 0),
                                                            blurRadius: 2,
                                                            color: context
                                                                .watch<
                                                                    ThemeProvider>()
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
                                                              .watch<
                                                                  ThemeProvider>()
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
                                                    Clipboard.setData(
                                                        ClipboardData(
                                                            text: snapshot.data
                                                                .toString()));
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                "Address copied!")));
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
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ColumnButtons(
                                text: "Terms & Conditions",
                                press: () {
                                  // Navigator.of(context).push(
                                  //     MaterialPageRoute(builder: (context) {
                                  //   return TermsAndConditionScreen();
                                  // }));
                                },
                                icon: "assets/icons/refer.png"),
                            ColumnButtons(
                                text: "Help & FAQ",
                                press: () {
                                  // Navigator.of(context).push(
                                  //     MaterialPageRoute(builder: (context) {
                                  //   return FAQScreen();
                                  // }));
                                },
                                icon: "assets/icons/faq.png"),
                            ColumnButtons(
                                text: "Feedback",
                                press: () {
                                  return Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return FeedbackScreen();
                                  }));
                                },
                                icon: "assets/icons/feedback.png"),
                            ColumnButtons(
                                text: "Logout",
                                press: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          backgroundColor: context
                                              .watch<ThemeProvider>()
                                              .getBackgroundColor(),
                                          elevation: 4,
                                          child: Container(
                                              height: 250,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      "Logout ",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: kPrimartFont(
                                                          context
                                                              .watch<
                                                                  ThemeProvider>()
                                                              .getPriamryFontColor(),
                                                          24,
                                                          FontWeight.bold),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .warning,
                                                        size: 20,
                                                        color: context
                                                            .watch<
                                                                ThemeProvider>()
                                                            .getHighLightColor(),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          "Are you sure?",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: kPrimartFont(
                                                              context
                                                                  .watch<
                                                                      ThemeProvider>()
                                                                  .getPriamryFontColor(),
                                                              18,
                                                              FontWeight.bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      GestureDetector(
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 20,
                                                            vertical: 10,
                                                          ),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: context
                                                                  .watch<
                                                                      ThemeProvider>()
                                                                  .getHighLightColor()),
                                                          child: Text(
                                                            "No",
                                                            style: kPrimartFont(
                                                              context
                                                                  .watch<
                                                                      ThemeProvider>()
                                                                  .getPriamryFontColor(),
                                                              22,
                                                              FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      GestureDetector(
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 20,
                                                            vertical: 10,
                                                          ),
                                                          decoration: BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    blurRadius:
                                                                        2,
                                                                    color: context
                                                                        .watch<
                                                                            ThemeProvider>()
                                                                        .getHighLightColor())
                                                              ],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: context
                                                                  .watch<
                                                                      ThemeProvider>()
                                                                  .getBackgroundColor()),
                                                          child: Text(
                                                            "Yes, Logout",
                                                            style: kPrimartFont(
                                                              context
                                                                  .watch<
                                                                      ThemeProvider>()
                                                                  .getPriamryFontColor(),
                                                              22,
                                                              FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          GoogleSignIn
                                                              _googleSignin =
                                                              GoogleSignIn(
                                                            scopes: [
                                                              'email',
                                                              'https://www.googleapis.com/auth/contacts.readonly',
                                                            ],
                                                          );
                                                          _googleSignin
                                                              .signOut();
                                                          print(
                                                              "> Logging out");
                                                          Storage().logout();
                                                          context
                                                              .read<
                                                                  NavigationProvider>()
                                                              .setCurrentIndex(
                                                                  0);
                                                          context
                                                              .read<
                                                                  ScanProvider>()
                                                              .resetProvider();
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
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
                                icon: "assets/icons/logout.png"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))));
  }
}

class RowItem extends StatelessWidget {
  final String label;
  final String value;

  RowItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 4,
        ),
        Text(
          value,
          style: kPrimartFont(
              context.watch<ThemeProvider>().getPriamryFontColor(),
              15,
              FontWeight.bold),
        ),
      ],
    );
  }
}

class RowButtons extends StatelessWidget {
  final String text;
  final Function press;
  final String icon;
  const RowButtons({
    Key? key,
    required this.text,
    required this.press,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => press(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            color: context.watch<ThemeProvider>().getHighLightColor(),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 100,
                  color: context
                      .watch<ThemeProvider>()
                      .getHighLightColor()
                      .withOpacity(0.22),
                  offset: Offset(0, 0)),
            ]),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Image.asset(
            icon,
            height: 42,
            width: 42,
          ),
          SizedBox(width: 5),
          Text(
            text,
            textAlign: TextAlign.center,
            style: kPrimartFont(
                context.watch<ThemeProvider>().getSecondaryFontColor(),
                18,
                FontWeight.bold),
          )
        ]),
      ),
    );
  }
}

class ColumnButtons extends StatelessWidget {
  final String text;
  final Function press;
  final String icon;
  const ColumnButtons({
    Key? key,
    required this.text,
    required this.press,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => press(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: context.watch<ThemeProvider>().getBackgroundColor(),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 100,
                  color: context
                      .watch<ThemeProvider>()
                      .getHighLightColor()
                      .withOpacity(0.22),
                  offset: Offset(0, 0)),
            ]),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              Image.asset(
                icon,
                height: 42,
                width: 42,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    18,
                    FontWeight.w600),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 28,
            color: context.watch<ThemeProvider>().getPriamryFontColor(),
          )
        ]),
      ),
    );
  }
}
