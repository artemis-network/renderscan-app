import 'package:flutter/material.dart';
import 'package:renderscan/screen/gallery/gallery_provider.dart';

// pages
import 'package:renderscan/screen/welcome/welcome_screen.dart';

// provider
import 'package:provider/provider.dart';
import 'package:renderscan/screen/scan/scan_provider.dart';

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
    return new WillPopScope(
        onWillPop: () async => false,
        child: MaterialApp(
            title: 'Renderscan',
            debugShowCheckedModeBanner: false,
            home: const SafeArea(
              child: Scaffold(
                body: WelcomeScreen(),
              ),
            )));
  }
}
