import 'dart:convert';
import 'dart:typed_data';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:renderscan/common/components/form/rounded_button.dart';
import 'package:renderscan/constants.dart';

import 'package:renderscan/screen/gallery/gallery_screen.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class MintScreen extends StatefulWidget {
  Uint8List img;
  MintScreen({Key? key, required this.img}) : super(key: key);

  @override
  State<MintScreen> createState() => _MintScreenState();
}

class _MintScreenState extends State<MintScreen> {
  @override
  Widget build(BuildContext context) {
    fun() {
      IO.Socket socket = IO.io(
          'http://192.168.1.14:5001',
          IO.OptionBuilder()
              .setTransports(['websocket'])
              .setTimeout(10000)
              .build());
      socket.connect();
      socket.onConnect((_) {
        print('connect');
      });
      print(socket.connected.toString());
      socket.onError((data) => print(data));
      var base64ImgString = base64Encode(widget.img).toString();
      socket.emit('message', base64ImgString);
    }

    mint() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: KprimaryBackGroundColor,
              title: Text(
                "Mint",
                style: GoogleFonts.poppins(
                    color: kPrimaryLightColor, fontWeight: FontWeight.bold),
              ),
              content: Text(
                "mint the nft on block chain ?",
                style: GoogleFonts.poppins(
                  color: kPrimaryLightColor,
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Mint",
                      style: GoogleFonts.poppins(
                          color: kPrimaryLightColor,
                          fontWeight: FontWeight.bold),
                    )),
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.poppins(
                          color: kPrimaryLightColor,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            );
          });
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
        ),
        backgroundColor: KprimaryBackGroundColor,
        body: Container(
            height: size.height * 0.85,
            width: size.width,
            child: Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                  child:
                      widget.img.isNotEmpty ? Image.memory(widget.img) : null,
                )),
                Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RoundedButton(text: "Mint", press: () => mint()),
                              RoundedButton(text: "Drop", press: fun),
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
                              onPressed: fun,
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
                          ],
                        ))
                  ],
                )
              ],
            )));
  }
}
