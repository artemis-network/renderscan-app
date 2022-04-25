import 'package:flutter/material.dart';
import 'package:renderscan/screen/gallery/gallery_provider.dart';
import 'package:renderscan/screen/signup/signup_screen.dart';

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
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SafeArea(
          child: Scaffold(
            body: SignUpScreen(),
          ),
        ));
  }
}
