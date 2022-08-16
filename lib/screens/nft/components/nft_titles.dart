import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/theme/theme_provider.dart';

class NFTTitles extends StatelessWidget {
  final String title;
  final IconData icon;

  NFTTitles({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(children: [
        Icon(
          icon,
          size: 35,
          color: context.watch<ThemeProvider>().getPriamryFontColor(),
        ),
        SizedBox(
          width: 12,
        ),
        Text(
          title,
          style: kPrimartFont(
              context.watch<ThemeProvider>().getPriamryFontColor(),
              24,
              FontWeight.w500),
        ),
      ]),
    );
  }
}
