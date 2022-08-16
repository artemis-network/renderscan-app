import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/theme/theme_provider.dart';

class NFTActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Text(
              "Share",
              style: kPrimartFont(
                  context.watch<ThemeProvider>().getPriamryFontColor(),
                  16,
                  FontWeight.bold),
            ),
            decoration: BoxDecoration(
                color: context.watch<ThemeProvider>().getBackgroundColor(),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 100,
                      color:
                          context.watch<ThemeProvider>().getBackgroundColor(),
                      offset: Offset(0, 0)),
                ])),
      ],
    );
  }
}
