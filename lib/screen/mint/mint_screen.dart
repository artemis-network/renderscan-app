import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:renderscan/common/components/form/rounded_button.dart';
import 'package:renderscan/constants.dart';

class MintScreen extends StatelessWidget {
  Uint8List img;
  MintScreen({Key? key, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: KprimaryBackGroundColor,
        body: Container(
            height: size.height * 0.8,
            width: size.width,
            child: Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                  child: img != null
                      ? Image.memory(
                          img,
                        )
                      : null,
                )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RoundedButton(text: "Mint", press: () => mint()),
                        RoundedButton(text: "Drop", press: () => mint()),
                      ]),
                )
              ],
            )));
  }
}
