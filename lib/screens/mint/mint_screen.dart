import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/loader.dart';
import 'package:renderscan/common/components/topbar/components/balance_widet.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/edit/background_edit.dart';
import 'package:renderscan/screens/generate/generate_api.dart';
import 'package:renderscan/screens/mint/components/modal_buttons.dart';
import 'package:renderscan/theme/theme_provider.dart';
import 'package:renderscan/utils/logger.dart';

class MintScreen extends StatefulWidget {
  final Uint8List imageSource;
  final String filename;
  MintScreen({Key? key, required this.imageSource, required this.filename})
      : super(key: key);

  @override
  State<MintScreen> createState() => _MintScreenState();
}

class _MintScreenState extends State<MintScreen> {
  bool isLoaded = true;

  List<String> c = [
    "#483838",
    "#42855B",
    "#B9FFF8",
    "#6FEDD6",
    "#FF4A4A",
    "#FF9551",
    "#F94892",
    "#293462",
    "#1CD6CE",
    "#2B4865",
    "#D61C4E",
    "#A47E3B",
  ];

  List<Color> colors = [
    Color(0xff483838),
    Color(0xff42855B),
    Color(0xffB9FFF8),
    Color(0xff6FEDD6),
    Color(0xffFF4A4A),
    Color(0xffFF9551),
    Color(0xffF94892),
    Color(0xff293462),
    Color(0xff1CD6CE),
    Color(0xff2B4865),
    Color(0xffD61C4E),
    Color(0xffA47E3B),
  ];

  String color = "";
  int currentColor = 0;
  late Uint8List img = widget.imageSource;

  @override
  Widget build(BuildContext context) {
    back() => Navigator.of(context).pop();

    final size = MediaQuery.of(context).size;

    mint() {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                elevation: 100,
                backgroundColor:
                    context.watch<ThemeProvider>().getBackgroundColor(),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  height: size.height * 0.4,
                  child: Stack(
                    children: [
                      Container(
                          child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(children: [
                          SizedBox(
                            height: size.height * 0.1,
                          ),
                          Text("Mint!",
                              textAlign: TextAlign.center,
                              style: kPrimartFont(
                                  context
                                      .watch<ThemeProvider>()
                                      .getPriamryFontColor(),
                                  20,
                                  FontWeight.bold)),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          Text(
                              "Minting image will write the image on to the block chain",
                              textAlign: TextAlign.center,
                              style: kPrimartFont(
                                  context
                                      .watch<ThemeProvider>()
                                      .getPriamryFontColor(),
                                  14,
                                  FontWeight.bold)),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ModalButton(
                                  text: "Close",
                                  onClick: back,
                                  color: "secondary"),
                              ModalButton(
                                  text: "Mint",
                                  onClick: back,
                                  color: "primary"),
                            ],
                          ),
                        ]),
                      )),
                      Positioned(
                          left: size.width * 0.3,
                          top: 5,
                          child: CircleAvatar(
                            child: Icon(
                              Icons.check_circle_outline,
                              size: 82,
                              color: Colors.greenAccent,
                            ),
                            backgroundColor: context
                                .watch<ThemeProvider>()
                                .getBackgroundColor(),
                          )),
                    ],
                  ),
                ));
          });
    }

    var scaffoldKey = GlobalKey<ScaffoldState>();
    goToEditScreen() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BackGroundEdit(
                    image: widget.imageSource,
                    imageType: "SCANNED",
                  )));
    }

    return Scaffold(
        backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
        key: scaffoldKey,
        drawerEnableOpenDragGesture: false,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [BalanceWidget()],
          ),
          backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
          leading: GestureDetector(
            onTap: () {
              scaffoldKey.currentState?.openDrawer();
            },
            child: Padding(
              child: Image.asset(
                "assets/icons/menu.png",
                height: 24,
                width: 24,
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
          ),
        ),
        drawer: Drawer(
          child: SideBar(),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    color: context.watch<ThemeProvider>().getBackgroundColor(),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: context
                              .watch<ThemeProvider>()
                              .getHighLightColor(),
                          blurRadius: 3)
                    ]),
                child: widget.imageSource.isNotEmpty
                    ? ClipRRect(
                        child: isLoaded
                            ? Image.memory(img, fit: BoxFit.fill)
                            : Container(
                                height: 250,
                                width: size.width * 0.8,
                                child: spinkit()),
                        borderRadius: BorderRadius.circular(20),
                      )
                    : null),
            Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 100,
                      width: size.width,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemCount: colors.length,
                          itemBuilder: (item, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  isLoaded = false;
                                });
                                GenerateApi()
                                    .addBackgroundImage(img, c[index])
                                    .then((value) {
                                  log.i(value);
                                  setState(() {
                                    img = value;
                                    isLoaded = true;
                                  });
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 16,
                                    child: CircleAvatar(
                                      radius: 14,
                                      backgroundColor: colors[index],
                                    )),
                              ),
                            );
                          }),
                    ),
                    Container(
                      width: size.width * 0.45,
                      decoration: BoxDecoration(
                          color: context
                              .watch<ThemeProvider>()
                              .getBackgroundColor(),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 100,
                                color: context
                                    .watch<ThemeProvider>()
                                    .getHighLightColor()
                                    .withOpacity(0.66),
                                offset: Offset(0, 0)),
                          ]),
                      child: TextButton(
                          child: Text("Mint",
                              style: kPrimartFont(
                                  context
                                      .watch<ThemeProvider>()
                                      .getPriamryFontColor(),
                                  14,
                                  FontWeight.bold)),
                          onPressed: () => mint()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: size.width * 0.45,
                      decoration: BoxDecoration(
                          color: context
                              .watch<ThemeProvider>()
                              .getHighLightColor(),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 0,
                                blurRadius: 100,
                                color: context
                                    .watch<ThemeProvider>()
                                    .getHighLightColor(),
                                offset: Offset(0, 0)),
                          ]),
                      child: TextButton(
                          onPressed: goToEditScreen,
                          child: Text("Edit",
                              style: kPrimartFont(
                                  Colors.white, 14, FontWeight.bold))),
                    )
                  ]),
              padding: EdgeInsets.symmetric(vertical: 60),
            ),
          ],
        ));
  }
}
