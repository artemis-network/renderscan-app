import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/common/components/topbar/topbar.dart';

import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';

import 'package:renderscan/screen/login/login_screen.dart';
import 'package:renderscan/screen/navigation/navigation_provider.dart';
import 'package:renderscan/screen/profile/component/profiile_buttons.dart';

import 'package:provider/provider.dart';
import 'package:renderscan/screen/scan/scan_provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    void logOut() {
      print("> Logging out");
      Storage().logout();
      context.read<ScanProvider>().resetProvider();
      context.read<NavigationProvider>().setCurrentIndex(2);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen(),
        ),
        (route) => false,
      );
    }

    goToUpgradePage() {
      context.read<NavigationProvider>().setCurrentIndex(4);
    }

    var scaffoldKey = GlobalKey<ScaffoldState>();

    bool allowClose = true;

    void fun() => (null);

    Widget screen() {
      return DoubleBack(
          condition: allowClose,
          onConditionFail: () {
            setState(() {
              allowClose = !allowClose;
            });
          },
          child: Scaffold(
            key: scaffoldKey,
            drawerEnableOpenDragGesture: false,
            drawer: Drawer(
              child: SideBar(),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                  color: context.watch<ThemeProvider>().getBackgroundColor(),
                  height: size.height,
                  width: size.width,
                  child: Column(
                    children: [
                      Topbar(
                        popSideBar: () =>
                            scaffoldKey.currentState?.openDrawer(),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/1.jpg'),
                          radius: 50,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Column(
                          children: [
                            FutureBuilder(
                                future: Storage().getItem('username'),
                                builder: (context, snapshot) {
                                  return Text(snapshot.data.toString(),
                                      style: kPrimartFont(
                                          context
                                              .watch<ThemeProvider>()
                                              .getPriamryFontColor(),
                                          18,
                                          FontWeight.bold));
                                }),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Dark Theme",
                                style: kPrimartFont(
                                    context
                                        .watch<ThemeProvider>()
                                        .getPriamryFontColor(),
                                    18,
                                    FontWeight.bold),
                              ),
                              Switch(
                                  value: context
                                      .watch<ThemeProvider>()
                                      .isDarkTheme(),
                                  onChanged: (r) {
                                    context.read<ThemeProvider>().setTheme(r);
                                  })
                            ]),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                        child: ProfileButton(
                          text: "Upgrade",
                          icon: Icons.upgrade,
                          onClick: goToUpgradePage,
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(70, 10, 70, 0),
                        child: Column(
                          children: [
                            ProfileButton(
                              text: "Privacy",
                              icon: Icons.privacy_tip_outlined,
                              onClick: fun,
                            ),
                            SizedBox(height: 10),
                            ProfileButton(
                              text: "Help & Support",
                              icon: Icons.help_center_outlined,
                              onClick: fun,
                            ),
                            SizedBox(height: 10),
                            ProfileButton(
                              text: "Settings",
                              icon: Icons.settings_outlined,
                              onClick: fun,
                            ),
                            SizedBox(height: 10),
                            ProfileButton(
                              text: "Refer a Friend",
                              icon: Icons.person_add_outlined,
                              onClick: fun,
                            ),
                            SizedBox(height: 10),
                            ProfileButton(
                              text: "Log out",
                              icon: Icons.logout_outlined,
                              onClick: logOut,
                            ),
                          ],
                        ),
                      ))
                    ],
                  )),
            ),
          ));
    }

    // return AuthFilter(
    //   screen: screen(),
    //   returnLoginPage: true,
    // );
    return screen();
  }
}
