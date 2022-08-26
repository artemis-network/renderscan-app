import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/theme/theme_provider.dart';

class QuoteLoader extends StatefulWidget {
  @override
  State<QuoteLoader> createState() => _QuoteLoaderState();
}

class _QuoteLoaderState extends State<QuoteLoader> {
  double time = 0;

  int currentIndex = 0;

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
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      print(time.toString() + "#" + timer.tick.toString());
      setState(() {
        time = (timer.tick + 1) / 60;
      });
      if (timer.tick >= 60 && time >= .95) timer.cancel();
      if (timer.tick % 10 == 0) {
        setState(() {
          currentIndex += 1;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    percentage() {
      if (time > .95) return "99%";
      return (time * 100).toStringAsFixed(0) + "%";
    }

    return Container(
        alignment: Alignment.center,
        child: (Column(
          children: [
            SizedBox(
              height: 30,
            ),
            CircularPercentIndicator(
              radius: 50.0,
              lineWidth: 10.0,
              percent: time > 1 ? 1 : time,
              center: new Text(
                percentage(),
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    22,
                    FontWeight.bold),
              ),
              progressColor: Colors.green,
            ),
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
        )));
  }
}
