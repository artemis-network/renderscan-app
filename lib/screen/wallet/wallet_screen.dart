import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/topbar/components/sidebar.dart';
import 'package:renderscan/common/components/topbar/topbar.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
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

    var scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            drawerEnableOpenDragGesture: false,
            drawer: Drawer(
              child: SideBar(),
            ),
            body: Container(
              color: context.watch<ThemeProvider>().getBackgroundColor(),
              child: Column(
                children: [
                  Topbar(
                    popSideBar: () => scaffoldKey.currentState?.openDrawer(),
                  ),
                  SingleChildScrollView(
                      child: Row(
                    children: [
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
                            style: kPrimartFont(
                                context
                                    .watch<ThemeProvider>()
                                    .getPriamryFontColor(),
                                20,
                                FontWeight.bold),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: context
                                    .watch<ThemeProvider>()
                                    .getBackgroundColor(),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 0,
                                      blurRadius: 100,
                                      color: context
                                          .watch<ThemeProvider>()
                                          .getHighLightColor()
                                          .withOpacity(0.66),
                                      offset: Offset(0, 0)),
                                ]),
                            clipBehavior: Clip.antiAlias,
                            child: Container(
                              child: Text(
                                "View All",
                                style: kPrimartFont(
                                    context
                                        .watch<ThemeProvider>()
                                        .getSecondaryFontColor(),
                                    14,
                                    FontWeight.normal),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                            ),
                          )
                        ],
                      )),
                  Expanded(
                      child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) =>
                              WalletTransactionList(
                                  title: data[index]['title'].toString(),
                                  subTitle: data[index]['subTitle'].toString(),
                                  trailing:
                                      data[index]['trailing'].toString())),
                    ),
                  ))
                ],
              ),
            )));
  }
}
