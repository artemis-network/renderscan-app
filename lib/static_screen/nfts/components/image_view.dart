import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/transistion_screen/edit/edit_screen.dart';

import 'package:http/http.dart' as http;

class ImageView extends StatefulWidget {
  final String url;
  final String tag;

  ImageView({required this.url, required this.tag});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  late Uint8List _image;

  init() async {
    final value = await http.get(Uri.parse(widget.url));
    Uint8List body = value.bodyBytes;
    setState(() {
      _image = body;
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
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: context.watch<ThemeProvider>().getPriamryFontColor(),
                  size: 32,
                )),
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
                Container(
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
                GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return (EditScreen(
                          image: _image,
                          url: widget.url,
                        ));
                      }));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        "Mint",
                        style: kPrimartFont(
                            context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            32,
                            FontWeight.bold),
                      ),
                      decoration: BoxDecoration(
                          color: context
                              .watch<ThemeProvider>()
                              .getBackgroundColor(),
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
