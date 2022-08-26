import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';

import 'package:http/http.dart' as http;
import 'package:renderscan/screens/edit/edit_screen.dart';
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
          child: Padding(
            child: Image.asset(
              "assets/icons/back.png",
              height: 24,
              width: 24,
            ),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          ),
        ),
        backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
        centerTitle: true,
        title: Text(
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
            Image.network(
              widget.url,
              height: 500,
              fit: BoxFit.fitWidth,
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
                      return (EditScreen(
                        image: _Gallery,
                      ));
                    }));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
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
                  child: Text(
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
