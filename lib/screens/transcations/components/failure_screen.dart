import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/navigation/navigation_screen.dart';
import 'package:renderscan/theme/theme_provider.dart';

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      body: Container(
          child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return NavigationScreen();
                  }));
                },
                icon: (Icon(
                  Icons.cancel_rounded,
                  size: 30,
                  color: context.watch<ThemeProvider>().getPriamryFontColor(),
                ))),
          ),
          SizedBox(
            height: 120,
          ),
          Container(
            alignment: Alignment.center,
            child: Column(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/images/lion.png",
                  height: 300,
                  width: 300,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Oops!",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    22,
                    FontWeight.bold),
              ),
              Text("Something went wrong on our side.",
                  style: kPrimartFont(
                      context.watch<ThemeProvider>().getPriamryFontColor(),
                      18,
                      FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              Text(
                "Please,",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    14,
                    FontWeight.normal),
              ),
              Text(
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
    ));
  }
}
