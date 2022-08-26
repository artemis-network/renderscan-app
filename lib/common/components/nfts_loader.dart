import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/loader.dart';
import 'package:renderscan/theme/theme_provider.dart';

class NFTsLoader extends StatefulWidget {
  @override
  State<NFTsLoader> createState() => NFTseLoaderState();
}

class NFTseLoaderState extends State<NFTsLoader> {
  int currentIndex = Random().nextInt(5);

  List<String> quotes = [
    '“Your new asset is in the digital world“ - NFT',
    '“NFTs are birth certificates for the offspring of creators“ - Dane Scarborough',
    '"NFT makes your art on your name" - Jawad Amir',
    '“Art is not a thing, it is a way” - Elbert Hubbard',
    '“Art is a line around your thoughts” - Gustav Klimt',
    '“NFTs are the future. But it"s not easy to get started“ - Our Founders',
    '“Keep calm & create your NFTs“ - RenderVerse'
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        color: context.watch<ThemeProvider>().getBackgroundColor(),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            spinkit(),
            SizedBox(
              height: 50,
            ),
            AnimatedContainer(
              duration: Duration(seconds: 1),
              child: Text(
                quotes[currentIndex],
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: context.watch<ThemeProvider>().getFavouriteColor(),
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30),
            ),
          ],
        ));
  }
}
