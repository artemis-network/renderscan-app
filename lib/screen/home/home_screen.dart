import 'package:flutter/material.dart';

// pages
import 'package:renderscan/screen/scan/scan_screen.dart';
import 'package:renderscan/screen/profile/profile_screen.dart';
import 'package:renderscan/screen/wallet/wallet_screen.dart';
import 'package:renderscan/screen/upgrade/upgrade_screen.dart';
import 'package:renderscan/screen/gallery/gallery_screen.dart';

// navbar
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// Global Vars
import 'package:renderscan/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final screens = [
    const GalleryScreen(),
    const ProfileScreen(),
    const ScanScreen(),
    const WalletScreen(),
    const UpgradeScreen(),
  ];

  int currentIndex = 0;
  void setIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return new WillPopScope(
        child: SafeArea(
            child: Scaffold(
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: screens[currentIndex],
          ),
          bottomNavigationBar: CurvedNavigationBar(
            index: 0,
            height: 50.0,
            items: <Widget>[
              Icon(
                Icons.picture_in_picture,
                size: 30,
                color: kPrimaryLightColor,
              ),
              Icon(Icons.person, size: 30, color: kPrimaryLightColor),
              Icon(Icons.home, size: 46, color: kPrimaryLightColor),
              Icon(
                Icons.account_balance_wallet,
                size: 30,
                color: kPrimaryLightColor,
              ),
              Icon(
                Icons.upgrade,
                size: 30,
                color: kPrimaryLightColor,
              ),
            ],
            color: kprimaryBottomBarColor,
            buttonBackgroundColor: kPrimaryColor,
            backgroundColor: kprimaryBackGroundColor,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 300),
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            letIndexChange: (index) => true,
          ),
        )),
        onWillPop: () async => false);
  }
}
