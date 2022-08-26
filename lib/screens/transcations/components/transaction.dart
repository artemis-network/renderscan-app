import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/theme/theme_provider.dart';

class Transaction extends StatelessWidget {
  final String title;
  final String subTitle;
  final String time;
  final String date;
  final String type;

  const Transaction(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.time,
      required this.date,
      required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: context.watch<ThemeProvider>().getBackgroundColor(),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                spreadRadius: 0,
                blurRadius: 2,
                color: context.watch<ThemeProvider>().getPriamryFontColor(),
                offset: Offset(0, 0)),
          ]),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        leading: CircleAvatar(
          child: Image.asset(
            "assets/icons/list.png",
            width: 32,
            height: 32,
          ),
        ),
        title: Text(
          type + " " + title,
          style: kPrimartFont(
              context.watch<ThemeProvider>().getPriamryFontColor(),
              16,
              FontWeight.bold),
        ),
        subtitle: Text(
          subTitle,
          style: kPrimartFont(
              context.watch<ThemeProvider>().getPriamryFontColor(),
              14,
              FontWeight.normal),
        ),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                time,
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    14,
                    FontWeight.normal),
              ),
              Text(
                date,
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    12,
                    FontWeight.bold),
              )
            ]),
      ),
    );
  }
}
