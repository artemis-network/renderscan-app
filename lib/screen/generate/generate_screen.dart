import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/common/components/topbar/topbar.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/generate/generate_api.dart';

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

    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: Drawer(
        child: SideBar(),
      ),
      body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Topbar(
                popSideBar: () => scaffoldKey.currentState?.openDrawer(),
              ),
              Expanded(
                child: Column(
                  children: [
                    Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                      child: Card(
                        child: Container(
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
                      ),
                      onTap: () async {
                        if (!isRequested) {
                          setState(() {
                            isRequested = true;
                          });
                          var image = await GenerateApi().generate(search);
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
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        context
                                            .watch<ThemeProvider>()
                                            .getHighLightColor()
                                            .withOpacity(.99)),
                                    backgroundColor: context
                                        .watch<ThemeProvider>()
                                        .getHighLightColor()
                                        .withOpacity(0.33),
                                    value: double.parse(value.toString()),
                                  ))
                          : Text(""),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(const Radius.circular(20.0))),
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 40),
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
    ));
  }
}
