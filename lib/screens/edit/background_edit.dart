import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/loader.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/edit/edit_screen.dart';
import 'package:renderscan/screens/generate/generate_api.dart';
import 'package:renderscan/theme/theme_provider.dart';

class BackGroundEdit extends StatefulWidget {
  final Uint8List image;
  final String imageType;

  BackGroundEdit({required this.image, required this.imageType});

  @override
  State<BackGroundEdit> createState() => _BackGroundEditState();
}

class _BackGroundEditState extends State<BackGroundEdit> {
  bool hasApplied = false;

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            child: Image.asset(
              "assets/icons/back.png",
              height: 24,
              width: 24,
            ),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
        backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
        centerTitle: true,
        title: Text(
          "Background",
          style: kPrimartFont(
              context.watch<ThemeProvider>().getPriamryFontColor(),
              30,
              FontWeight.bold),
        ),
      ),
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colors[currentColor],
                ),
                child: Image.memory(
                  widget.image,
                  fit: BoxFit.fill,
                ),
              ),
              Column(
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
                                currentColor = index;
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        hasApplied = true;
                      });
                      GenerateApi()
                          .addBackgroundImage(widget.image, c[currentColor])
                          .then((value) {
                        setState(() {
                          hasApplied = false;
                        });
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return EditScreen(
                              image: value, imageType: widget.imageType);
                        }));
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(20),
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 0,
                              blurRadius: 2,
                              color: context
                                  .watch<ThemeProvider>()
                                  .getHighLightColor(),
                              offset: Offset(0, 0)),
                        ],
                        color:
                            context.watch<ThemeProvider>().getHighLightColor(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: hasApplied
                          ? spinkit()
                          : Text(
                              "Next",
                              textAlign: TextAlign.center,
                              style: kPrimartFont(
                                  Colors.white, 18, FontWeight.bold),
                            ),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
