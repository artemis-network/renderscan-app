import 'package:flutter/material.dart';

// provider
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:renderscan/static_screen/home/home_provider.dart';
import 'package:renderscan/static_screen/navigation/navigation_provider.dart';
import 'package:renderscan/transistion_screen/scan/scan_provider.dart';
import 'package:renderscan/transistion_screen/welcome/welcome_screen.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ScanProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool allowClose = false;

  @override
  Widget build(BuildContext context) {
    bool allowClose = false;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DoubleBack(
        condition: allowClose,
        onConditionFail: () {
          setState(() {
            allowClose = true;
          });
        },
        // message: "Press back again to exit",
        child: SafeArea(
          child: Scaffold(
            body: DoubleBack(
              condition: allowClose,
              onConditionFail: () {
                setState(() {
                  allowClose = true;
                });
              },
              child: WelcomeScreen(),
              // child: NFTScreen(
              //   contractAddress: "0x12d2d1bed91c24f878f37e66bd829ce7197e4d14",
              //   tokenId: "201",
              //   totalSupply: 1000,
              // ),
              waitForSecondBackPress: 3, // default 2
              textStyle: TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
              background: Colors.red,
              backgroundRadius: 30,
            ),
          ),
        ),
        // onFirstBackPress: (context) {
        //   // change this with your custom action
        //   final snackBar = SnackBar(content: Text('Press back again to exit'));
        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //   // ---
        // },
        waitForSecondBackPress: 3, // default 2
        textStyle: TextStyle(
          fontSize: 13,
          color: Colors.white,
        ),
        background: Colors.red,
        backgroundRadius: 30,
      ),
    );
  }
}
