import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/common/components/topbar/topbar.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/static_screen/navigation/navigation_provider.dart';
import 'package:renderscan/static_screen/profile/profile_api.dart';
import 'package:renderscan/static_screen/profile/profile_provider.dart';
import 'package:renderscan/static_screen/profile/profile_screen.dart';
import 'package:renderscan/transistion_screen/scan/scan_provider.dart';

class UserScreen extends StatefulWidget {
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String displayName = "";
  String language = "";
  String region = "";

  @override
  void initState() {
    ProfileApi().getProfile().then((value) {
      setState(() {
        displayName = value.displayName;
        language = value.language;
        region = value.region;
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
              body: Container(
                  color: context.watch<ThemeProvider>().getBackgroundColor(),
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  height: size.height,
                  width: size.width,
                  child: Column(
                    children: [
                      Topbar(
                          popSideBar: () =>
                              scaffoldKey.currentState?.openDrawer()),
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
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/1.jpg'),
                              radius: 48,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FutureBuilder(
                                      future: Storage().getItem('username'),
                                      builder: (context, snapshot) {
                                        return RowItem(
                                            label: "Username",
                                            value: snapshot.data.toString());
                                      }),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RowItem(
                                        label: "Display Name",
                                        value: displayName,
                                      ),
                                    ],
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
                                      language: language);
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
                        width: size.width * 0.8,
                        margin: EdgeInsets.symmetric(vertical: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ColumnButtons(
                                text: "Terms & Conditions",
                                press: () {},
                                icon: Icons.rule),
                            SizedBox(
                              height: 20,
                            ),
                            ColumnButtons(
                                text: "Privacy Policy",
                                press: () {},
                                icon: Icons.privacy_tip_outlined),
                            SizedBox(
                              height: 20,
                            ),
                            ColumnButtons(
                                text: "Help & FAQ",
                                press: () {},
                                icon: Icons.help_center_outlined),
                            SizedBox(
                              height: 20,
                            ),
                            ColumnButtons(
                                text: "Logout",
                                press: () {
                                  print("> Logging out");
                                  Storage().logout();
                                  context
                                      .read<NavigationProvider>()
                                      .setCurrentIndex(0);
                                  context.read<ScanProvider>().resetProvider();
                                },
                                icon: Icons.logout)
                          ],
                        ),
                      )
                    ],
                  )),
            )));
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
        Text(
          label,
          style: kPrimartFont(
              context.watch<ThemeProvider>().getSecondaryFontColor(),
              15,
              FontWeight.normal),
        ),
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
        padding: EdgeInsets.all(10),
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
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Icon(
              icon,
              size: 28,
              color: context.watch<ThemeProvider>().getPriamryFontColor(),
            ),
          ),
          SizedBox(
            width: 24,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: kPrimartFont(
                  context.watch<ThemeProvider>().getPriamryFontColor(),
                  20,
                  FontWeight.w600),
            ),
          )
        ]),
      ),
    );
  }
}
