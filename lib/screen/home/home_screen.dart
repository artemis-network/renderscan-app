import 'package:flutter/material.dart';
import 'package:renderscan/constants.dart';

// pages
import 'package:renderscan/screen/scan/scan_screen.dart';
import 'package:renderscan/screen/profile/profile_screen.dart';
import 'package:renderscan/screen/wallet/wallet_screen.dart';
import 'package:renderscan/screen/upgrade/upgrade_screen.dart';
import 'package:renderscan/screen/gallery/gallery_screen.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';

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

  int currentIndex = 2;
  void setIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
        title: 'Renderscan',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: SafeArea(
            child: Scaffold(
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: screens[currentIndex],
          ),
          bottomNavigationBar: CurvedNavigationBar(
            index: 2,
            height: 50.0,
            items: <Widget>[
              Icon(
                Icons.picture_in_picture,
                size: 30,
                color: kPrimaryLightColor,
              ),
              Icon(Icons.person, size: 30, color: kPrimaryLightColor),
              Icon(Icons.camera, size: 46, color: kPrimaryLightColor),
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
            color: kPrimaryColor,
            buttonBackgroundColor: kPrimaryColor,
            backgroundColor: KprimaryBackGroundColor,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            letIndexChange: (index) => true,
          ),
        )));
  }
}
