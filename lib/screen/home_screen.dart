import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/main.dart';

// providers
import 'package:renderscan/provider/screen.dart';

// pages
import 'package:renderscan/screen/home/gallery_screen.dart';
import 'package:renderscan/screen/home/profile_screen.dart';
import 'package:renderscan/screen/home/scan_screen.dart';
import 'package:renderscan/screen/home/wallet_screen.dart';
import 'package:renderscan/screen/home/help_screen.dart';

class HomeScreen extends StatefulWidget {
  late List<CameraDescription>? cameras;

  HomeScreen({Key? key, required this.cameras}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final screens = [
    ScanScreen(cameras: cameras),
    const GalleryScreen(),
    const ProfileScreen(),
    const WalletScreen(),
    const HelpScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: SafeArea(
          child: Scaffold(
            body: SizedBox(
              height: size.height,
              width: size.width,
              child: screens[context.watch<ScreenStateProvider>().currentIndex],
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
                    label: 'Settings',
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
                currentIndex: context.watch<ScreenStateProvider>().currentIndex,
                selectedItemColor: Colors.teal[800],
                onTap: (index) =>
                    context.read<ScreenStateProvider>().setPage(index)),
          ),
        ));
  }
}
