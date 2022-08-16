import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/static_screen/navigation/navigation_screen.dart';

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
                "Wow!",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    22,
                    FontWeight.bold),
              ),
              Text("You've made it.",
                  style: kPrimartFont(
                      context.watch<ThemeProvider>().getPriamryFontColor(),
                      18,
                      FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              Text(
                "congrats,",
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    14,
                    FontWeight.normal),
              ),
              Text(
                "you received 100R.",
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
