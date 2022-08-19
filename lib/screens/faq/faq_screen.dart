import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/theme/theme_provider.dart';

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
        centerTitle: true,
        title: Text(
          "FAQ & HELP",
          style: kPrimartFont(
              context.watch<ThemeProvider>().getPriamryFontColor(),
              26,
              FontWeight.bold),
        ),
      ),
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      "assets/images/lion.png",
                      fit: BoxFit.fitWidth,
                      height: 300,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Tell us how we can help?",
                      textAlign: TextAlign.center,
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                          26,
                          FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      FAQItem(
                          image: "assets/images/lion.png",
                          main: "Chat",
                          sub: "Start a conservation now!"),
                      FAQItem(
                          image: "assets/images/lion.png",
                          main: "FAQs",
                          sub: "Find intelligent anwsers instantly"),
                      FAQItem(
                          image: "assets/images/lion.png",
                          main: "Email",
                          sub: "Get solutions beamed to your inbox"),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String image;
  final String main;
  final String sub;

  FAQItem({required this.image, required this.main, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 1,
                color: context.watch<ThemeProvider>().getHighLightColor())
          ],
          borderRadius: BorderRadius.circular(10),
          color: context.watch<ThemeProvider>().getBackgroundColor()),
      child: Row(children: [
        SizedBox(
          width: 10,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            image,
            height: 64,
            width: 64,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              main,
              style: kPrimartFont(
                  context.watch<ThemeProvider>().getPriamryFontColor(),
                  18,
                  FontWeight.bold),
            ),
            Text(
              sub,
              style: kPrimartFont(
                  context.watch<ThemeProvider>().getPriamryFontColor(),
                  14,
                  FontWeight.normal),
            ),
          ],
        )
      ]),
    );
  }
}
