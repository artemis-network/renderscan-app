import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/balance_widet.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/edit/edit_screen.dart';
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
              builder: (context) => EditScreen(
                    image: widget.imageSource,
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
          children: [
            Container(
                height: size.height * 0.8,
                width: size.width * .8,
                child: Column(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                      child: widget.imageSource.isNotEmpty
                          ? Card(
                              elevation: 100,
                              shadowColor: context
                                  .watch<ThemeProvider>()
                                  .getHighLightColor()
                                  .withOpacity(0.66),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35)),
                              clipBehavior: Clip.antiAlias,
                              color: context
                                  .watch<ThemeProvider>()
                                  .getBackgroundColor(),
                              child: Image.memory(widget.imageSource),
                            )
                          : null,
                    )),
                    Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 0),
                                    child: Container(
                                      width: size.width * 0.48,
                                      child: TextButton(
                                          child: Text("Mint"),
                                          onPressed: () => mint()),
                                      decoration: BoxDecoration(
                                          color: context
                                              .watch<ThemeProvider>()
                                              .getBackgroundColor(),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                                spreadRadius: 0,
                                                blurRadius: 100,
                                                color: context
                                                    .watch<ThemeProvider>()
                                                    .getHighLightColor()
                                                    .withOpacity(0.66),
                                                offset: Offset(0, 0)),
                                          ]),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Container(
                                        width: size.width * 0.48,
                                        decoration: BoxDecoration(
                                            color: context
                                                .watch<ThemeProvider>()
                                                .getBackgroundColor(),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                  spreadRadius: 0,
                                                  blurRadius: 100,
                                                  color: context
                                                      .watch<ThemeProvider>()
                                                      .getHighLightColor()
                                                      .withOpacity(0.66),
                                                  offset: Offset(0, 0)),
                                            ]),
                                        child: TextButton(
                                            child: Text("Edit"),
                                            onPressed: goToEditScreen),
                                      ))
                                ])),
                      ],
                    )
                  ],
                ))
          ],
        ));
  }
}
