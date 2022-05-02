import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:renderscan/constants.dart';

import 'package:renderscan/screen/gallery/gallery_screen.dart';
import 'package:renderscan/screen/mint/components/modal_buttons.dart';
import 'package:renderscan/screen/mint/mint_api.dart';

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

    drop() {
      MintApi().drop(widget.filename).then((value) {
        print(value);
        print(value.statusCode);
        print(value.body);
      }).catchError((onError) => (null));
    }

    final size = MediaQuery.of(context).size;

    mint() {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                elevation: 5,
                backgroundColor: kPrimaryColor,
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
                                  kPrimaryLightColor, 20, FontWeight.bold)),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          Text(
                              "Minting image will write the image on to the block chain",
                              textAlign: TextAlign.center,
                              style: kPrimartFont(
                                  kPrimaryLightColor, 14, FontWeight.bold)),
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
                            backgroundColor: kPrimaryColor,
                          )),
                    ],
                  ),
                ));
          });
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
        ),
        backgroundColor: kprimaryBackGroundColor,
        body: Container(
            height: size.height * 0.85,
            width: size.width,
            child: Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                  child: widget.imageSource.isNotEmpty
                      ? Image.memory(widget.imageSource)
                      : null,
                )),
                Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 0),
                                child: Container(
                                  width: size.width * 0.48,
                                  child: TextButton(
                                      child: Text("Mint"),
                                      onPressed: () => mint()),
                                  decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(20),
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
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Container(
                                    width: size.width * 0.48,
                                    decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius: BorderRadius.circular(20),
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
                                    child: TextButton(
                                        child: Text("Drop"), onPressed: drop),
                                  ))
                            ])),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const GalleryScreen()),
                                );
                              },
                              child: Icon(
                                Icons.picture_in_picture,
                                color: kPrimaryLightColor,
                              ),
                              style: OutlinedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  side: const BorderSide(
                                      color: Colors.transparent),
                                  padding: const EdgeInsets.all(15),
                                  elevation: 5,
                                  backgroundColor: kPrimaryColor,
                                  shadowColor: Colors.grey.withOpacity(0.2)),
                            ),
                            OutlinedButton(
                              onPressed: back,
                              child: Icon(
                                Icons.edit,
                                color: kPrimaryLightColor,
                              ),
                              style: OutlinedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  side: const BorderSide(
                                      color: Colors.transparent),
                                  padding: const EdgeInsets.all(15),
                                  elevation: 5,
                                  backgroundColor: kPrimaryColor,
                                  shadowColor: Colors.grey.withOpacity(0.2)),
                            ),
                            OutlinedButton(
                              onPressed: back,
                              child: Icon(
                                Icons.upgrade,
                                color: kPrimaryLightColor,
                              ),
                              style: OutlinedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  side: const BorderSide(
                                      color: Colors.transparent),
                                  padding: const EdgeInsets.all(15),
                                  elevation: 5,
                                  backgroundColor: kPrimaryColor,
                                  shadowColor: Colors.grey.withOpacity(0.2)),
                            ),
                          ],
                        ))
                  ],
                )
              ],
            )));
  }
}
