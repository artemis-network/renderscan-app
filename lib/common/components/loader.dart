import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:renderscan/constants.dart';

spinkit() {
  List<String> quotes = [
    '“Your new asset is in the digital world“ - NFT',
    '“NFTs are birth certificates for the offspring of creators“ - Dane Scarborough',
    '"NFT makes your art on your name" - Jawad Amir',
    '“Art is not a thing, it is a way” – Elbert Hubbard',
    '“Art is a line around your thoughts” – Gustav Klimt',
    '“NFTs are the future. But it’s not easy to get started“ - Our Founders',
    '“Keep calm & create your NFTs“ - RenderVerse'
  ];
  final rand = new Random().nextInt(5);
  return WillPopScope(
      child: Container(
          alignment: Alignment.center,
          child: (Column(
            children: [
              SizedBox(
                height: 100,
              ),
              SpinKitDoubleBounce(color: Colors.amber, size: 100),
              Container(
                child: Text(
                  quotes[rand],
                  textAlign: TextAlign.center,
                  style: kPrimartFont(Colors.amberAccent, 18, FontWeight.w600),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30),
              ),
            ],
          ))),
      onWillPop: () async => false);
}
