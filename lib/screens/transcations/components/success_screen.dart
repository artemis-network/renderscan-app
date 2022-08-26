import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/transcations/components/buy_ruby_modal.dart';
import 'package:renderscan/theme/theme_provider.dart';

class SuccessScreen extends StatelessWidget {
  final String amount;

  SuccessScreen({required this.amount});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Padding(
              child: Image.asset(
                "assets/icons/back.png",
                height: 24,
                width: 24,
              ),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            ),
          ),
          elevation: 0,
          backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
        ),
        backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
        body: Container(
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Lottie.asset(
                "assets/lottie/success.json",
                height: 240,
                width: 240,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Congrats!",
              style: kPrimartFont(
                  context.watch<ThemeProvider>().getPriamryFontColor(),
                  22,
                  FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(amount,
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        18,
                        FontWeight.bold)),
                SizedBox(
                  width: 4,
                ),
                Image.asset(
                  "assets/icons/pruby.png",
                  height: 20,
                  width: 20,
                ),
                SizedBox(
                  width: 4,
                ),
                Text("added to your wallet",
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        18,
                        FontWeight.bold)),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return BuyRubyModal();
                }));
              },
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(20),
                width: size.width * 0.65,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 0,
                        blurRadius: 2,
                        color:
                            context.watch<ThemeProvider>().getHighLightColor(),
                        offset: Offset(0, 0)),
                  ],
                  color: context.watch<ThemeProvider>().getHighLightColor(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Buy",
                      textAlign: TextAlign.center,
                      style: kPrimartFont(Colors.white, 24, FontWeight.bold),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Image.asset(
                      "assets/icons/pruby.png",
                      height: 32,
                      width: 32,
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}
