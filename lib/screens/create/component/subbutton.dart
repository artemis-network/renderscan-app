import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/theme/theme_provider.dart';

class SubButton extends StatelessWidget {
  final String buttonLabel;
  final Function onClick;
  final String url;

  SubButton(
      {required this.buttonLabel, required this.onClick, required this.url});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => onClick(),
      child: Container(
          width: size.width * 0.55,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Image.asset(
              url,
              height: 30,
              width: 30,
            ),
            Text(
              buttonLabel,
              style: kPrimartFont(
                  context.watch<ThemeProvider>().getPriamryFontColor(),
                  18,
                  FontWeight.bold),
            ),
            SizedBox()
          ]),
          decoration: BoxDecoration(
              color: context.watch<ThemeProvider>().getHighLightColor(),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 1,
                    color: context.watch<ThemeProvider>().getHighLightColor(),
                    offset: Offset(0, 0)),
              ])),
    );
  }
}
