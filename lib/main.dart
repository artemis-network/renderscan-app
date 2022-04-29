import 'package:flutter/material.dart';
import 'package:renderscan/screen/gallery/gallery_provider.dart';

// pages
import 'package:renderscan/screen/welcome/welcome_screen.dart';

// provider
import 'package:provider/provider.dart';
import 'package:renderscan/screen/scan/scan_provider.dart';

import 'package:double_back_to_close/double_back_to_close.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScanProvider()),
        ChangeNotifierProvider(create: (_) => GalleryProvider())
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
  @override
  Widget build(BuildContext context) {
    bool allowClose = false;
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SafeArea(
          child: Scaffold(
            body: DoubleBack(
              condition: allowClose,
              onConditionFail: () {
                setState(() {
                  allowClose = true;
                });
              },
              child: WelcomeScreen(),
              waitForSecondBackPress: 3, // default 2
              textStyle: TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
              background: Colors.red,
              backgroundRadius: 30,
            ),
          ),
        ));
  }
}
