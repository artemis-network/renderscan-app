import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/screen/wallet/wallet_api.dart';
import 'package:renderscan/screen/wallet/wallet_dto.dart';
import 'package:renderscan/constants.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  late Wallet wallet;

  Future<Wallet> setUpWallet() async {
    final username = await Storage().getItem("username");
    return await WalletApi().getBalance(username.toString());
  }

  getBalance() {
    return FutureBuilder(
        future: setUpWallet(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState.name == "done") {
            final data = snapshot.data as Wallet;
            return Text(
              data.balance.toString() + " RNDV",
              style: GoogleFonts.poppins(
                  color: kPrimaryLightColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            );
          } else {
            return Text(
              0.toString() + " RNDV",
              style: GoogleFonts.poppins(
                  color: kPrimaryLightColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            );
          }
        });
  }

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
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 2,
                        color: kprimaryNeuLight,
                        offset: Offset(-1, -1)),
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 8,
                        color: kprimaryNeuDark,
                        offset: Offset(5, 5)),
                  ]),
              height: size.height * 0.15,
              width: size.width * 0.9,
              child: Row(children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Balance",
                          style: kPrimartFont(
                              kPrimaryLightColor, 14, FontWeight.bold),
                        ),
                        Text(
                          "10000 RNDV",
                          style: kPrimartFont(
                              kPrimaryLightColor, 14, FontWeight.bold),
                        ),
                        // getBalance()
                      ],
                    )),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Account",
                        style: kPrimartFont(
                            kPrimaryLightColor, 14, FontWeight.bold),
                      ),
                      Text(
                        "0xcff8...",
                        style: kPrimartFont(
                            kPrimaryLightColor, 18, FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonWidget(
                      icon: Icons.add_outlined,
                      text: "Deposit",
                      callback: () => null),
                  ButtonWidget(
                      icon: Icons.transfer_within_a_station_outlined,
                      text: "Transfer",
                      callback: () => null),
                  ButtonWidget(
                      icon: Icons.send_outlined,
                      text: "Send",
                      callback: () => null),
                  ButtonWidget(
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
                itemBuilder: (context, index) => ListItemWidget(
                    title: data[index]['title'].toString(),
                    subTitle: data[index]['subTitle'].toString(),
                    trailing: data[index]['trailing'].toString())),
          ))
        ],
      ),
    ));
  }
}

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback callback;

  const ButtonWidget(
      {Key? key,
      required this.icon,
      required this.text,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed: null,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 2,
                        color: kprimaryNeuLight,
                        offset: Offset(-1, -1)),
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 8,
                        color: kprimaryNeuDark,
                        offset: Offset(5, 5)),
                  ]),
              child: Icon(
                icon,
                color: kPrimaryLightColor,
              ),
            )),
        SizedBox(
          height: 5,
        ),
        Text(text,
            style: kPrimartFont(kPrimaryLightColor, 12, FontWeight.normal))
      ],
    );
  }
}

class ListItemWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String trailing;

  const ListItemWidget(
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
