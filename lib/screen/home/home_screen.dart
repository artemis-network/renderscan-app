import 'package:flutter/material.dart';

// pages
import 'package:renderscan/screen/scan/scan_screen.dart';
import 'package:renderscan/screen/profile/profile_screen.dart';
import 'package:renderscan/screen/wallet/wallet_screen.dart';
import 'package:renderscan/screen/upgrade/upgrade_screen.dart';
import 'package:renderscan/screen/gallery/gallery_screen.dart';

// navbar
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

//gallery api
import 'package:renderscan/screen/gallery/gallery_api.dart';
import 'package:renderscan/screen/gallery/gallery_models.dart';

// Global Vars
import 'package:renderscan/constants.dart';

// provider
import 'package:provider/provider.dart';
import 'package:renderscan/screen/gallery/gallery_provider.dart';

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

  void initImageList(ImageList imageList) {
    List<ImageItem>? images = imageList.images;
    if (images!.isNotEmpty)
      return context.read<GalleryProvider>().initializeImageList(images);
    return context.read<GalleryProvider>().initializeImageList([]);
  }

  @override
  void initState() {
    GalleryApi().callImages().then((imageList) => initImageList(imageList));
    super.initState();
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
