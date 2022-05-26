import 'package:flutter/material.dart';
import 'package:renderscan/common/components/loader.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/screen/home/home_protector_screen.dart';
import 'package:renderscan/screen/scan/scan_api.dart';
import 'package:renderscan/screen/scan/scan_modal.dart';

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

// home provider
import 'package:renderscan/screen/home/home_provider.dart';
import 'package:provider/provider.dart';

//
import 'package:renderscan/common/components/exit_dialog.dart';

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
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: screens[context.watch<HomeProvider>().currentIndex],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          index: context.watch<HomeProvider>().currentIndex,
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
            context.read<HomeProvider>().setCurrentIndex(index);
          },
          letIndexChange: (index) => true,
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
