import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// providers
import 'package:renderscan/provider/image.dart';
import 'package:renderscan/provider/screen.dart';

// pages
import 'package:renderscan/screen/welcome_screen.dart';

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ImageP()),
      ChangeNotifierProvider(create: (_) => ScreenStateProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SafeArea(
          child: Scaffold(
            body: WelcomeScreen(
              cameras: cameras,
            ),
          ),
        ));
  }
}
