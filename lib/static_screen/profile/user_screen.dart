import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/common/components/topbar/topbar.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/static_screen/navigation/navigation_provider.dart';
import 'package:renderscan/static_screen/profile/profile_api.dart';
import 'package:renderscan/static_screen/profile/profile_provider.dart';
import 'package:renderscan/static_screen/profile/profile_screen.dart';
import 'package:renderscan/transistion_screen/feedback/feedback_screen.dart';
import 'package:renderscan/transistion_screen/scan/scan_provider.dart';
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
    log.i(webUrl);
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
    final size = MediaQuery.of(context).size;

    bool allowClose = true;

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
                drawerEnableOpenDragGesture: false,
                drawer: Drawer(child: SideBar()),
                body: SingleChildScrollView(
                  child: Container(
                      color:
                          context.watch<ThemeProvider>().getBackgroundColor(),
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      height: size.height,
                      width: size.width,
                      child: Column(
                        children: [
                          Topbar(
                              popSideBar: () =>
                                  scaffoldKey.currentState?.openDrawer()),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 30),
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
                                        final username =
                                            snapshot.data as String;
                                        var url =
                                            "https://renderscan-user-avatars.s3.ap-south-1.amazonaws.com/" +
                                                username +
                                                '.png';
                                        log.i(url);
                                        return CircleAvatar(
                                          backgroundImage: NetworkImage(url),
                                          radius: 48,
                                        );
                                      }
                                      return CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/lion.png"),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        child: Text(
                                          "0xc20d....ac1",
                                          style: kPrimartFont(
                                              context
                                                  .watch<ThemeProvider>()
                                                  .getSecondaryFontColor(),
                                              15,
                                              FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RowButtons(
                                    text: "Edit Profile",
                                    press: () {
                                      Profile profile = Profile(
                                          displayName: displayName,
                                          region: region,
                                          language: language,
                                          email: email);
                                      context
                                          .read<ProfileProvider>()
                                          .setProfile(profile);
                                      Navigator.of(context).push(PageTransition(
                                          type: PageTransitionType.leftToRight,
                                          child: ProfileScreen(),
                                          ctx: context,
                                          duration: Duration(milliseconds: 300),
                                          fullscreenDialog: true,
                                          childCurrent: UserScreen()));
                                    },
                                    icon: Icons.edit_outlined),
                                RowButtons(
                                    text: "Share Profile",
                                    press: () {},
                                    icon: Icons.share_outlined),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ColumnButtons(
                                    text: "Terms & Conditions",
                                    press: () {
                                      launchPage();
                                    },
                                    icon: Icons.rule),
                                ColumnButtons(
                                    text: "Privacy Policy",
                                    press: () {
                                      launchPage();
                                    },
                                    icon: Icons.privacy_tip_outlined),
                                ColumnButtons(
                                    text: "Help & FAQ",
                                    press: () {
                                      launchPage();
                                    },
                                    icon: Icons.help_center_outlined),
                                ColumnButtons(
                                    text: "Feedback",
                                    press: () {
                                      return Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return FeedbackScreen();
                                      }));
                                    },
                                    icon: Icons.feedback),
                                ColumnButtons(
                                    text: "Logout",
                                    press: () {
                                      Storage().logout();
                                      context
                                          .read<NavigationProvider>()
                                          .setCurrentIndex(0);
                                      context
                                          .read<ScanProvider>()
                                          .resetProvider();
                                    },
                                    icon: Icons.logout)
                              ],
                            ),
                          ),
                        ],
                      )),
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
  final IconData icon;
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
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            color: context.watch<ThemeProvider>().getBackgroundColor(),
            borderRadius: BorderRadius.circular(40),
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
        child: Row(children: [
          Icon(
            icon,
            size: 22,
            color: context.watch<ThemeProvider>().getPriamryFontColor(),
          ),
          SizedBox(
            width: 10,
          ),
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
  final IconData icon;
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
              Icon(
                icon,
                size: 24,
                color: context.watch<ThemeProvider>().getPriamryFontColor(),
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
            Icons.arrow_forward,
            size: 28,
            color: context.watch<ThemeProvider>().getPriamryFontColor(),
          )
        ]),
      ),
    );
  }
}
