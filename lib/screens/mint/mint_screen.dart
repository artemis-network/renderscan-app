import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/balance_widet.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/edit/background_edit.dart';
import 'package:renderscan/screens/mint/components/modal_buttons.dart';
import 'package:renderscan/theme/theme_provider.dart';

class MintScreen extends StatefulWidget {
  final Uint8List imageSource;
  final String filename;
  MintScreen({Key? key, required this.imageSource, required this.filename})
      : super(key: key);

  @override
  State<MintScreen> createState() => _MintScreenState();
}

class _MintScreenState extends State<MintScreen> {
  String color = "";
  int currentColor = 0;

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
                          AutoSizeText("Mint!",
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
                          AutoSizeText("Let's do this, Mint now ?",
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
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return BackGroundEdit(image: widget.imageSource, imageType: "SCANNED");
      }));
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
            child: Container(
              child: Image.asset(
                "assets/icons/menu.png",
                height: 24,
                width: 24,
              ),
              margin: EdgeInsets.only(left: 18),
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.memory(
                widget.imageSource,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                          child: AutoSizeText("Mint",
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
                          child: AutoSizeText("Edit",
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
