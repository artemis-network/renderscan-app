import 'package:flutter/material.dart';
import 'package:renderscan/screen/wallet/components/wallet_banner.dart';
import 'package:renderscan/screen/wallet/components/wallet_rounded_button.dart';
import 'package:renderscan/screen/wallet/components/wallet_transcation_list.dart';
import 'package:renderscan/constants.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var data = [
      {"title": "Rendle 7", "subTitle": "Entry Fee", "trailing": "2000 RNDV"},
      {"title": "Rendle 5", "subTitle": "Entry Fee", "trailing": "1000 RNDV"},
      {"title": "Rendle 6", "subTitle": "Entry Fee", "trailing": "1500 RNDV"},
      {"title": "Rendle 5", "subTitle": "Entry Fee", "trailing": "1000 RNDV"},
      {"title": "Rendle 6", "subTitle": "Entry Fee", "trailing": "1500 RNDV"},
      {"title": "Rendle 5", "subTitle": "Entry Fee", "trailing": "1000 RNDV"},
      {"title": "Rendle 6", "subTitle": "Entry Fee", "trailing": "1500 RNDV"},
      {"title": "Rendle 5", "subTitle": "Entry Fee", "trailing": "1000 RNDV"},
    ];

    return Scaffold(
        body: Container(
      color: kprimaryBackGroundColor,
      child: Column(
        children: [
          SingleChildScrollView(
              child: Row(
            children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: kPrimaryColor),
                  width: size.width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(children: [
                          Column(children: [
                            Text("WALLET",
                                style: kPrimartFont(
                                    kPrimaryLightColor, 24, FontWeight.bold)),
                          ]),
                        ]),
                      ])),
              Container(
                decoration: BoxDecoration(color: kPrimaryColor),
                alignment: Alignment.centerRight,
              ),
            ],
          )),
          WalletBanner(size: size),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  WalletRoundedButton(
                      icon: Icons.add_outlined,
                      text: "Deposit",
                      callback: () => null),
                  WalletRoundedButton(
                      icon: Icons.transfer_within_a_station_outlined,
                      text: "Transfer",
                      callback: () => null),
                  WalletRoundedButton(
                      icon: Icons.send_outlined,
                      text: "Send",
                      callback: () => null),
                  WalletRoundedButton(
                      icon: Icons.receipt_long_outlined,
                      text: "Recieve",
                      callback: () => null),
                ]),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Last Transcations",
                    style:
                        kPrimartFont(kPrimaryLightColor, 20, FontWeight.bold),
                  ),
                  Text(
                    "View All",
                    style:
                        kPrimartFont(kPrimaryLightColor, 14, FontWeight.normal),
                  ),
                ],
              )),
          Expanded(
              child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) => WalletTransactionList(
                    title: data[index]['title'].toString(),
                    subTitle: data[index]['subTitle'].toString(),
                    trailing: data[index]['trailing'].toString())),
          ))
        ],
      ),
    ));
  }
}
