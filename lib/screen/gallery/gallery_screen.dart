import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/gallery/gallery_api.dart';
import 'package:renderscan/screen/gallery/gallery_models.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);
  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  void initState() {
    super.initState();
  }

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
    return FutureBuilder(
        future: GalleryApi().callImages(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState.name == 'done') {
            final data = snapshot.data as ImageList;
            return Expanded(
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
                      child: Hero(
                        tag: 'logo$index',
                        child: Container(
                          child: Image.memory(
                            base64StringToUInt8List(
                                data.images![index].nft.toString()),
                            height: 120,
                            width: 160,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: new AssetImage(
                                  data.images![index].nft.toString()),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: data.images?.length,
                ),
              ),
            );
          }
          return Container(
            child: Text("coo"),
          );
        });
  }
}
