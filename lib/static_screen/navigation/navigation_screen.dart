import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/utils/storage.dart';

// home provider
import 'package:provider/provider.dart';

import 'package:renderscan/common/components/exit_dialog.dart';
import 'package:renderscan/static_screen/create/create_screen.dart';
import 'package:renderscan/static_screen/explore/explore_screen.dart';
import 'package:renderscan/static_screen/home/home_screen.dart';
import 'package:renderscan/static_screen/navigation/navigation_provider.dart';
import 'package:renderscan/static_screen/nfts/nfts_screen.dart';
import 'package:renderscan/static_screen/profile/user_screen.dart';
import 'package:renderscan/transistion_screen/login/login_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final screens = [
    HomeScreen(),
    ExploreScreen(),
    CreateScreen(),
    NFTSScreen(),
    UserScreen()
  ];

  home(Size size) {
    return AppExitDialogWrapper(
      child: SafeArea(
          child: Scaffold(
        body: Container(
          child: screens[context.watch<NavigationProvider>().currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: context.watch<ThemeProvider>().getNavbarColor(),
          elevation: 10,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor:
              context.watch<ThemeProvider>().getHighLightColor(),
          unselectedIconTheme: IconThemeData(
              color: context.watch<ThemeProvider>().getSecondaryFontColor()),
          selectedIconTheme: IconThemeData(
              color: context.watch<ThemeProvider>().getHighLightColor()),
          selectedItemColor: context.watch<ThemeProvider>().getHighLightColor(),
          currentIndex: context.watch<NavigationProvider>().currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                size: 24,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search_outlined,
                size: 24,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                size: 34,
                color: context.watch<ThemeProvider>().getFavouriteColor(),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.library_books_outlined,
                size: 24,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline_outlined,
                size: 24,
              ),
              label: "",
            ),
          ],
          onTap: (index) async {
            final bool isLoggedIn = await Storage().isLoggedIn();
            if ((index == 3 || index == 4) && !isLoggedIn) {
              Navigator.of(context).push(PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: LoginScreen(),
                  ctx: context,
                  fullscreenDialog: true,
                  duration: Duration(milliseconds: 300),
                  childCurrent: NavigationScreen()));
              return;
            }
            return context.read<NavigationProvider>().setCurrentIndex(index);
          },
        ),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return home(size);
  }
}
