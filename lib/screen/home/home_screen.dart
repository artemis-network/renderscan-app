import 'package:flutter/material.dart';

// pages
import 'package:renderscan/screen/scan/scan_screen.dart';
import 'package:renderscan/screen/profile/profile_screen.dart';
import 'package:renderscan/screen/wallet/wallet_screen.dart';
import 'package:renderscan/screen/help/help_screen.dart';
import 'package:renderscan/screen/gallery/gallery_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final screens = [
    const ScanScreen(),
    const GalleryScreen(),
    const ProfileScreen(),
    const WalletScreen(),
    const HelpScreen(),
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
    return MaterialApp(
        title: 'Renderscan',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SafeArea(
          child: Scaffold(
            body: SizedBox(
              height: size.height,
              width: size.width,
              child: screens[currentIndex],
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      size: 26,
                      color: Colors.blueAccent,
                    ),
                    label: 'Clip',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.folder_outlined,
                      size: 26,
                      color: Colors.blueAccent,
                    ),
                    label: 'Gallery',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person_outlined,
                      size: 26,
                      color: Colors.blueAccent,
                    ),
                    label: 'Profile',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.wallet_travel_outlined,
                      size: 26,
                      color: Colors.blueAccent,
                    ),
                    label: 'Wallet',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.help_center_outlined,
                      size: 26,
                      color: Colors.blueAccent,
                    ),
                    label: 'Help',
                  ),
                ],
                currentIndex: currentIndex,
                selectedItemColor: Colors.blue[800],
                onTap: (index) => setIndex(index)),
          ),
        ));
  }
}
