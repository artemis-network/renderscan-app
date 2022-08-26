import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

// home provider
import 'package:provider/provider.dart';

import 'package:renderscan/common/components/exit_dialog.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/create/create_screen.dart';
import 'package:renderscan/screens/explore/explore_screen.dart';
import 'package:renderscan/screens/gallery/gallery_screen.dart';
import 'package:renderscan/screens/home/home_screen.dart';
import 'package:renderscan/screens/login/login_screen.dart';
import 'package:renderscan/screens/profile/user_screen.dart';
import 'package:renderscan/theme/theme_provider.dart';
import 'package:renderscan/utils/storage.dart';

class NavigationScreen extends StatefulWidget {
  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final PageStorageBucket bucket = PageStorageBucket();

  Widget currentScreen = HomeScreen();
  int currentTab = 0;

  home(Size size) {
    return AppExitDialogWrapper(
        child: Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: context.watch<ThemeProvider>().getPriamryFontColor(),
          size: 48,
        ),
        onPressed: () async {
          final bool isLoggedIn = await Storage().isLoggedIn();
          if (!isLoggedIn) {
            Navigator.of(context).push(PageTransition(
                type: PageTransitionType.bottomToTop,
                child: LoginScreen(),
                ctx: context,
                fullscreenDialog: true,
                duration: Duration(milliseconds: 300),
                childCurrent: NavigationScreen()));
            return;
          } else {
            setState(() {
              currentTab = 2;
              currentScreen = CreateScreen();
            });
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Container(
          decoration: BoxDecoration(
              color: context.watch<ThemeProvider>().getBackgroundColor(),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  offset: Offset(0, -1),
                  spreadRadius: 0,
                  color: context.watch<ThemeProvider>().getBackgroundColor(),
                ),
                BoxShadow(
                  blurRadius: 2,
                  offset: Offset(0, -2),
                  spreadRadius: 1,
                  color: context.watch<ThemeProvider>().getBackgroundColor(),
                )
              ]),
          height: 60,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = HomeScreen();
                      currentTab = 0;
                    });
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          constraints:
                              BoxConstraints(maxHeight: 30, maxWidth: 30),
                          child: Image.asset(
                            "assets/icons/h.png",
                            height: 30,
                            width: 30,
                          ),
                        ),
                        Text(
                          "Home",
                          style: kPrimartFont(
                              currentTab == 0
                                  ? context
                                      .watch<ThemeProvider>()
                                      .getHighLightColor()
                                  : context
                                      .watch<ThemeProvider>()
                                      .getPriamryFontColor(),
                              13,
                              FontWeight.bold),
                        )
                      ]),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = ExploreScreen();
                      currentTab = 1;
                    });
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          constraints:
                              BoxConstraints(maxHeight: 30, maxWidth: 30),
                          child: Image.asset(
                            "assets/icons/e.png",
                            height: 30,
                            width: 30,
                          ),
                        ),
                        Text(
                          "Explore",
                          style: kPrimartFont(
                              currentTab == 1
                                  ? context
                                      .watch<ThemeProvider>()
                                      .getHighLightColor()
                                  : context
                                      .watch<ThemeProvider>()
                                      .getPriamryFontColor(),
                              13,
                              FontWeight.bold),
                        )
                      ]),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  minWidth: 40,
                  onPressed: () async {
                    final bool isLoggedIn = await Storage().isLoggedIn();
                    if (!isLoggedIn) {
                      Navigator.of(context).push(PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: LoginScreen(),
                          ctx: context,
                          fullscreenDialog: true,
                          duration: Duration(milliseconds: 300),
                          childCurrent: NavigationScreen()));
                      return;
                    } else {
                      setState(() {
                        currentScreen = GalleryScreen();
                        currentTab = 3;
                      });
                    }
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          constraints:
                              BoxConstraints(maxHeight: 30, maxWidth: 30),
                          child: Image.asset(
                            "assets/icons/nfts.png",
                            height: 30,
                            width: 30,
                          ),
                        ),
                        Text(
                          "NFTs",
                          style: kPrimartFont(
                              currentTab == 3
                                  ? context
                                      .watch<ThemeProvider>()
                                      .getHighLightColor()
                                  : context
                                      .watch<ThemeProvider>()
                                      .getPriamryFontColor(),
                              13,
                              FontWeight.bold),
                        )
                      ]),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () async {
                    final bool isLoggedIn = await Storage().isLoggedIn();
                    if (!isLoggedIn) {
                      Navigator.of(context).push(PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: LoginScreen(),
                          ctx: context,
                          fullscreenDialog: true,
                          duration: Duration(milliseconds: 300),
                          childCurrent: NavigationScreen()));
                      return;
                    } else {
                      setState(() {
                        currentScreen = UserScreen();
                        currentTab = 4;
                      });
                    }
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          constraints:
                              BoxConstraints(maxHeight: 30, maxWidth: 30),
                          child: Image.asset(
                            "assets/icons/profile.png",
                            height: 30,
                            width: 30,
                          ),
                        ),
                        Text(
                          "Profile",
                          style: kPrimartFont(
                              currentTab == 4
                                  ? context
                                      .watch<ThemeProvider>()
                                      .getHighLightColor()
                                  : context
                                      .watch<ThemeProvider>()
                                      .getPriamryFontColor(),
                              13,
                              FontWeight.bold),
                        )
                      ]),
                ),
              ],
            )
          ]),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return home(size);
  }
}
