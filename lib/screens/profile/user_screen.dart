import 'dart:math';

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/balance_widet.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';

import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/faq/faq_screen.dart';
import 'package:renderscan/screens/feedback/feedback_screen.dart';
import 'package:renderscan/screens/navigation/navigation_provider.dart';
import 'package:renderscan/screens/navigation/navigation_screen.dart';
import 'package:renderscan/screens/profile/profile_api.dart';
import 'package:renderscan/screens/profile/profile_provider.dart';
import 'package:renderscan/screens/profile/profile_screen.dart';
import 'package:renderscan/screens/scan/scan_provider.dart';
import 'package:renderscan/screens/terms_and_conditions/terms_and_condition.dart';
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
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                                    final username = snapshot.data as String;
                                    var url =
                                        "https://renderscan-user-avatars.s3.ap-south-1.amazonaws.com/" +
                                            username +
                                            '.png';

                                    return Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(url),
                                          radius: 48,
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
                                                        type: PageTransitionType
                                                            .leftToRight,
                                                        child: ProfileScreen(),
                                                        ctx: context,
                                                        duration: Duration(
                                                            milliseconds: 300),
                                                        fullscreenDialog: true,
                                                        childCurrent:
                                                            UserScreen()));
                                              },
                                            ))
                                      ],
                                    );
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
                                        return Text(
                                          "@" + snapshot.data.toString(),
                                          style: kPrimartFont(
                                              context
                                                  .watch<ThemeProvider>()
                                                  .getSecondaryFontColor(),
                                              16,
                                              FontWeight.normal),
                                        );
                                      }),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                              "0xc20...223133",
                                              style: kPrimartFont(
                                                  context
                                                      .watch<ThemeProvider>()
                                                      .getSecondaryFontColor(),
                                                  15,
                                                  FontWeight.normal),
                                            ),
                                          )),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      GestureDetector(
                                          onTap: () {},
                                          child: Image.asset(
                                            "assets/icons/copy.png",
                                            height: 16,
                                            width: 16,
                                          ))
                                    ],
                                  ),
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
                                  Storage().logout();
                                  context.read<ScanProvider>().resetProvider();
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return NavigationScreen();
                                  }));
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
