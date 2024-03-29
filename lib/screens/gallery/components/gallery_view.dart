import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';

import 'package:http/http.dart' as http;
import 'package:renderscan/screens/edit/background_edit.dart';
import 'package:renderscan/theme/theme_provider.dart';

class GalleryView extends StatefulWidget {
  final String url;
  final String tag;

  GalleryView({required this.url, required this.tag});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  late Uint8List _Gallery;

  init() async {
    final value = await http.get(Uri.parse(widget.url));
    Uint8List body = value.bodyBytes;
    setState(() {
      _Gallery = body;
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            child: Image.asset(
              "assets/icons/back.png",
              height: 24,
              width: 24,
            ),
            margin: EdgeInsets.only(left: 18),
          ),
        ),
        backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
        centerTitle: true,
        title: AutoSizeText(
          "Edit",
          style: kPrimartFont(
              context.watch<ThemeProvider>().getPriamryFontColor(),
              30,
              FontWeight.bold),
        ),
      ),
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: Image.network(
                widget.url,
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return (BackGroundEdit(
                        image: _Gallery,
                        imageType: "SCANNED",
                      ));
                    }));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: AutoSizeText(
                      "Edit",
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                          32,
                          FontWeight.bold),
                    ),
                    decoration: BoxDecoration(
                        color:
                            context.watch<ThemeProvider>().getBackgroundColor(),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 2,
                              color: context
                                  .watch<ThemeProvider>()
                                  .getHighLightColor()),
                        ]),
                  ),
                ),
                GestureDetector(
                    child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: AutoSizeText(
                    "Mint",
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        32,
                        FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                      color:
                          context.watch<ThemeProvider>().getBackgroundColor(),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 2,
                            color: context
                                .watch<ThemeProvider>()
                                .getHighLightColor()),
                      ]),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
