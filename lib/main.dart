import 'package:flutter/material.dart';

// provider
import 'package:provider/provider.dart';

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:renderscan/screens/home/home_provider.dart';
import 'package:renderscan/screens/navigation/navigation_provider.dart';
import 'package:renderscan/screens/profile/profile_provider.dart';
import 'package:renderscan/screens/scan/scan_provider.dart';
import 'package:renderscan/screens/welcome/welcome_screen.dart';
import 'package:renderscan/theme/theme_provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
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
            //   contractAddress: "0x57f1887a8bf19b14fc0df6fd9b2acc9af147ea85",
            //   tokenId:
            //       "108106047680392530126901775778300423889446504647977261612367594080961297289170",
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
