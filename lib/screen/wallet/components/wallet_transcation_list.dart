import 'package:flutter/material.dart';
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
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: kPrimaryLightColor,
        child: Icon(
          Icons.receipt_outlined,
          color: kprimaryBackGroundColor,
        ),
      ),
      title: Text(
        title,
        style: kPrimartFont(kPrimaryLightColor, 14, FontWeight.normal),
      ),
      subtitle: Text(
        subTitle,
        style: kPrimartFont(kPrimaryLightColor, 14, FontWeight.normal),
      ),
      trailing: Text(
        trailing,
        style: kPrimartFont(kPrimaryLightColor, 14, FontWeight.normal),
      ),
    );
  }
}
