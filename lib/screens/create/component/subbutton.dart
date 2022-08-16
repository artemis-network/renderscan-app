import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';

class SubButton extends StatelessWidget {
  final String buttonLabel;
  final Function onClick;

  SubButton({required this.buttonLabel, required this.onClick});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => onClick(),
      child: Container(
          width: size.width * 0.45,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            buttonLabel,
            style: kPrimartFont(
                context.watch<ThemeProvider>().getPriamryFontColor(),
                24,
                FontWeight.bold),
          ),
          decoration: BoxDecoration(
              color: context.watch<ThemeProvider>().getBackgroundColor(),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 4,
                    blurRadius: 2,
                    color: context.watch<ThemeProvider>().getFavouriteColor(),
                    offset: Offset(0, 0)),
              ])),
    );
  }
}
