import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/quote_loader.dart';
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
  bool isLoaded = false;

  late AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            backgroundColor:
                context.watch<ThemeProvider>().getBackgroundColor(),
            body: SingleChildScrollView(
              child: Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: context
                              .watch<ThemeProvider>()
                              .getPriamryFontColor(),
                        )),
                  ),
                  Column(
                    children: [
                      Container(
                        child: img != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.memory(
                                  img!,
                                  height: 300,
                                  width: 300,
                                ),
                              )
                            : isRequested
                                ? Container(
                                    child: QuoteLoader(),
                                    margin: EdgeInsets.only(bottom: 30),
                                  )
                                : Container(
                                    child: ClipRRect(
                                      child: Container(
                                        child: Image.asset(
                                          "assets/icons/generate.png",
                                          height: 175,
                                          width: 175,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                const Radius.circular(20.0))),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 40),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                      ),
                      img != null
                          ? AnimatedContainer(
                              duration: Duration(microseconds: 250),
                              padding: EdgeInsets.all(20),
                              width: size.width * 0.6,
                              decoration: BoxDecoration(
                                  color: context
                                      .watch<ThemeProvider>()
                                      .getBackgroundColor(),
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 0,
                                        blurRadius: 100,
                                        color: context
                                            .watch<ThemeProvider>()
                                            .getHighLightColor()
                                            .withOpacity(0.22),
                                        offset: Offset(0, 0)),
                                  ]),
                              child: Text(
                                "save",
                                textAlign: TextAlign.center,
                                style: kPrimartFont(
                                    context
                                        .watch<ThemeProvider>()
                                        .getSecondaryFontColor(),
                                    18,
                                    FontWeight.bold),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
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
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Text("Input text to generate NFT",
                            style: kPrimartFont(
                              context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
                              22,
                              FontWeight.bold,
                            )),
                      ),
                      Container(
                        width: 300,
                        child: Form(
                          key: fKey,
                          child: TextField(
                            style: kPrimartFont(
                                context
                                    .watch<ThemeProvider>()
                                    .getPriamryFontColor(),
                                22,
                                FontWeight.normal),
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
                      InkWell(
                        child: Container(
                            margin: EdgeInsets.symmetric(vertical: 30),
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
                            var image = await GenerateApi().generate(search);
                            setState(() {
                              img = image;
                              isRequested = false;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              )),
            )));
  }
}
