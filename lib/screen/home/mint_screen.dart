import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:renderscan/components/rounded_button.dart';

class MintScreen extends StatelessWidget {
  Uint8List img;

  MintScreen({Key? key, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.ac_unit),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
            width: size.width,
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Expanded(
                    child: Container(
                  child: img != null
                      ? Image.memory(
                          img,
                        )
                      : null,
                )),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RoundedButton(text: "Mint", press: () => print("hello")),
                      RoundedButton(text: "Drop", press: () => print("hello")),
                    ])
              ],
            )));
  }
}
