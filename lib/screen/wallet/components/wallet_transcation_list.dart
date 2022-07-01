import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';

class WalletTransactionList extends StatelessWidget {
  final String title;
  final String subTitle;
  final String trailing;

  const WalletTransactionList(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.trailing})
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
                blurRadius: 100,
                color: context
                    .watch<ThemeProvider>()
                    .getHighLightColor()
                    .withOpacity(0.33),
                offset: Offset(0, 0)),
          ]),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
          child: Icon(
            Icons.receipt_outlined,
            color: context.watch<ThemeProvider>().getPriamryFontColor(),
          ),
        ),
        title: Text(
          title,
          style: kPrimartFont(
              context.watch<ThemeProvider>().getPriamryFontColor(),
              14,
              FontWeight.normal),
        ),
        subtitle: Text(
          subTitle,
          style: kPrimartFont(
              context.watch<ThemeProvider>().getPriamryFontColor(),
              14,
              FontWeight.normal),
        ),
        trailing: Text(
          trailing,
          style: kPrimartFont(
              context.watch<ThemeProvider>().getPriamryFontColor(),
              14,
              FontWeight.normal),
        ),
      ),
    );
  }
}
