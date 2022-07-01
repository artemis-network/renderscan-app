import 'package:flutter/material.dart';
import 'package:renderscan/common/components/loader.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/screen/home/home_protector_screen.dart';
import 'package:renderscan/screen/nfts/nfts_screen.dart';
import 'package:renderscan/screen/scan/scan_api.dart';
import 'package:renderscan/screen/scan/scan_modal.dart';

// pages
// import 'package:renderscan/screen/scan/scan_screen.dart';
import 'package:renderscan/screen/profile/profile_screen.dart';
import 'package:renderscan/screen/wallet/wallet_screen.dart';
import 'package:renderscan/screen/upgrade/upgrade_screen.dart';
// import 'package:renderscan/screen/gallery/gallery_screen.dart';
import 'package:renderscan/screen/main/main.dart';
import 'package:renderscan/screen/explore/explore_screen.dart';

// navbar
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// Global Vars
import 'package:renderscan/constants.dart';

// home provider
import 'package:renderscan/screen/home/home_provider.dart';
import 'package:provider/provider.dart';

//
import 'package:renderscan/common/components/exit_dialog.dart';
import 'package:renderscan/screen/create/create_screen.dart';
import 'package:renderscan/screen/welcome/welcome_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final screens = [
    MainScreen(),
    ExploreScreen(),
    CreateScreen(),
    NFTSScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    ScanApi().hasAccountActivated("").then((resp) {
      bool isActivated = resp.isActivated;
      if (!isActivated) {
        return HomProtectorScreen();
      }
    }).catchError((err) {
      log.e(err);
    });
    super.initState();
  }

  home(Size size) {
    return AppExitDialogWrapper(
      child: SafeArea(
          child: Scaffold(
        body: Container(
          child: screens[context.watch<HomeProvider>().currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
          elevation: 10,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor:
              context.watch<ThemeProvider>().getForegroundColor(),
          unselectedIconTheme: IconThemeData(
              color: context.watch<ThemeProvider>().getForegroundColor()),
          selectedIconTheme: IconThemeData(
              color: context.watch<ThemeProvider>().getHighLightColor()),
          selectedItemColor: context.watch<ThemeProvider>().getHighLightColor(),
          currentIndex: context.watch<HomeProvider>().currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  size: 24,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search_outlined,
                  size: 24,
                ),
                label: "Explore"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle,
                  size: 34,
                  color: context.watch<ThemeProvider>().getForegroundColor(),
                ),
                activeIcon: Icon(
                  Icons.add_circle,
                  size: 34,
                  color: context.watch<ThemeProvider>().getHighLightColor(),
                ),
                label: "Create"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.library_books_outlined,
                  size: 24,
                ),
                label: "NFTs"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outline_outlined,
                  size: 24,
                ),
                label: "Profile"),
          ],
          onTap: (index) {
            context.read<HomeProvider>().setCurrentIndex(index);
          },
        ),
      )),
    );
  }

  HomeProtectionWrapper(Size size) {
    return FutureBuilder(
      future: ScanApi().hasAccountActivated(""),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        log.i(snapshot.connectionState.name);
        log.i(snapshot.data);
        if (snapshot.connectionState.name == "done") {
          final data = snapshot.data as ScanProtectionResponse;
          log.i(data.message);
          log.i(data.isActivated);
          if (!data.isActivated) return HomProtectorScreen();
          // return home(size);
          return home(size);
        }
        return Container(
          child: spinkit,
          alignment: Alignment.center,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return home(size);
  }
}
