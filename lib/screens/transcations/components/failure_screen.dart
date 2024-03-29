import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/theme/theme_provider.dart';

class FailureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [],
        backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      ),
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Column(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Lottie.asset(
                  "assets/lottie/error.json",
                  height: 300,
                  width: 300,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              AutoSizeText(
                "Oops!",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    22,
                    FontWeight.bold),
              ),
              AutoSizeText("Uh-Oh, Your Payment was Declined 💳",
                  style: kPrimartFont(
                      context.watch<ThemeProvider>().getPriamryFontColor(),
                      18,
                      FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              AutoSizeText(
                "Please,",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    14,
                    FontWeight.normal),
              ),
              AutoSizeText(
                "Try after sometime.",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    14,
                    FontWeight.normal),
              ),
            ]),
          )
        ],
      )),
    );
  }
}
