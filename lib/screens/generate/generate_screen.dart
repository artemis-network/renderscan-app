import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/common/components/topbar/topbar.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/generate/generate_api.dart';
import 'package:renderscan/theme/theme_provider.dart';

class GenerateScreen extends StatefulWidget {
  @override
  State<GenerateScreen> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> fKey = GlobalKey<FormState>();
  Uint8List? img;
  String search = "";
  bool isRequested = false;

  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    final size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            drawerEnableOpenDragGesture: false,
            drawer: Drawer(
              child: SideBar(),
            ),
            body: SingleChildScrollView(
              child: Container(
                  color: context.watch<ThemeProvider>().getBackgroundColor(),
                  height: size.height,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Topbar(
                        popSideBar: () =>
                            scaffoldKey.currentState?.openDrawer(),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: ClipRRect(
                                child: Image.asset(
                                  "assets/images/lion.png",
                                  height: 150,
                                  width: 150,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Text(
                                "Turn imagination into art. Powered by the latest technology, our AI creates art and images based on simple text instructions.",
                                textAlign: TextAlign.center,
                                style: kPrimartFont(
                                    context
                                        .watch<ThemeProvider>()
                                        .getPriamryFontColor(),
                                    14,
                                    FontWeight.normal),
                              ),
                            ),
                            Card(
                              shadowColor: context
                                  .watch<ThemeProvider>()
                                  .getHighLightColor(),
                              color: context
                                  .watch<ThemeProvider>()
                                  .getBackgroundColor(),
                              margin: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  child: Text("Input text to generate NFT",
                                      style: kPrimartFont(
                                        context
                                            .watch<ThemeProvider>()
                                            .getPriamryFontColor(),
                                        22,
                                        FontWeight.bold,
                                      ))),
                            ),
                            Container(
                              width: 300,
                              child: Form(
                                key: fKey,
                                child: TextField(
                                  cursorColor: context
                                      .watch<ThemeProvider>()
                                      .getHighLightColor(),
                                  cursorWidth: 2,
                                  decoration: InputDecoration(
                                    hintText: "Enter item",
                                    hintStyle: kPrimartFont(
                                        context
                                            .watch<ThemeProvider>()
                                            .getPriamryFontColor(),
                                        18,
                                        FontWeight.normal),
                                    fillColor: context
                                        .watch<ThemeProvider>()
                                        .getPriamryFontColor(),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            width: 3,
                                            color: context
                                                .watch<ThemeProvider>()
                                                .getHighLightColor())),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            width: 3,
                                            color: context
                                                .watch<ThemeProvider>()
                                                .getHighLightColor())),
                                    focusColor: context
                                        .watch<ThemeProvider>()
                                        .getHighLightColor(),
                                  ),
                                  enabled: !isRequested,
                                  onChanged: ((value) => setState(() {
                                        search = value;
                                      })),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: context
                                          .watch<ThemeProvider>()
                                          .getBackgroundColor(),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 1,
                                            color: context
                                                .watch<ThemeProvider>()
                                                .getHighLightColor())
                                      ]),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Text(
                                    "Generate",
                                    style: kPrimartFont(
                                        context
                                            .watch<ThemeProvider>()
                                            .getPriamryFontColor(),
                                        22,
                                        FontWeight.bold),
                                  )),
                              onTap: () async {
                                if (!isRequested) {
                                  setState(() {
                                    isRequested = true;
                                  });
                                  var image =
                                      await GenerateApi().generate(search);
                                  setState(() {
                                    img = image;
                                    isRequested = false;
                                  });
                                }
                              },
                            ),
                            Container(
                              child: isRequested
                                  ? TweenAnimationBuilder(
                                      tween: Tween(begin: 0.0, end: 1.0),
                                      duration: Duration(seconds: 70),
                                      builder: (context, value, _) =>
                                          CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    context
                                                        .watch<ThemeProvider>()
                                                        .getHighLightColor()
                                                        .withOpacity(.99)),
                                            backgroundColor: context
                                                .watch<ThemeProvider>()
                                                .getHighLightColor()
                                                .withOpacity(0.33),
                                            value:
                                                double.parse(value.toString()),
                                          ))
                                  : Text(""),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      const Radius.circular(20.0))),
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 40),
                            ),
                            Container(
                              color: Colors.blue,
                              child: img != null
                                  ? Image.memory(
                                      img!,
                                      height: 300,
                                      width: 300,
                                    )
                                  : Text(""),
                            ),
                            img != null
                                ? InkWell(
                                    child: Text("Refresh"),
                                    onTap: () {
                                      Future.delayed(Duration(seconds: 10), () {
                                        final i = GenerateApi().refresh();
                                        setState(() {
                                          img = i;
                                        });
                                      });
                                    })
                                : Text(""),
                          ],
                        ),
                      )
                    ],
                  )),
            )));
  }
}
