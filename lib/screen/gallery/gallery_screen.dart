import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/gallery/gallery_api.dart';
import 'package:renderscan/screen/gallery/gallery_models.dart';

import 'package:provider/provider.dart';
import 'package:renderscan/screen/gallery/gallery_provider.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);
  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimaryBackGroundColor,
      body: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            Text(
              'Gallery',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: kPrimaryLightColor,
              ),
              textAlign: TextAlign.center,
            ),
            _GalleryGrid()
          ])),
    );
  }
}

class _GalleryGrid extends StatelessWidget {
  Uint8List base64StringToUInt8List(String base64String) =>
      base64Decode(base64String);

  @override
  Widget build(BuildContext context) {
    List<ImageItem> imageList = context.watch<GalleryProvider>().imagesList;

    if (imageList.length == 0)
      return Container(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
          child: Text(
            "Gallery is empty",
            style: kPrimartFont(kPrimaryLightColor, 20, FontWeight.bold),
            textAlign: TextAlign.center,
          ));

    return Container(
      child: Expanded(
          child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 80,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return RawMaterialButton(
              onPressed: () {},
              child: Padding(
                padding: EdgeInsets.all(3),
                child: Container(
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 2,
                            color: kprimaryNeuLight,
                            offset: Offset(-1, -1)),
                        BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 8,
                            color: kprimaryNeuDark,
                            offset: Offset(5, 5)),
                      ]),
                  child: Image.memory(
                    base64StringToUInt8List(imageList[index].nft.toString()),
                    height: 120,
                    width: 160,
                  ),
                ),
              ),
            );
          },
          itemCount: imageList.length,
        ),
      )),
    );
  }
}
