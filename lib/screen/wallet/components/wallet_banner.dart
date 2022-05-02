import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:renderscan/common/utils/storage.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screen/wallet/wallet_api.dart';
import 'package:renderscan/screen/wallet/wallet_dto.dart';
// import 'package:renderscan/screen/wallet/wallet_api.dart';
// import 'package:renderscan/screen/wallet/wallet_dto.dart';

class WalletBanner extends StatefulWidget {
  final Size size;
  WalletBanner({Key? key, required this.size});
  @override
  State<WalletBanner> createState() => _WalletBannerState();
}

class _WalletBannerState extends State<WalletBanner> {
  @override
  Widget build(BuildContext context) {
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

    return Padding(
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
        height: widget.size.height * 0.15,
        width: widget.size.width * 0.9,
        child: Row(children: [
          Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Balance",
                    style:
                        kPrimartFont(kPrimaryLightColor, 14, FontWeight.bold),
                  ),
                  // Text(
                  //   "10000 RNDV",
                  //   style:
                  //       kPrimartFont(kPrimaryLightColor, 14, FontWeight.bold),
                  // ),
                  getBalance()
                ],
              )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Account",
                  style: kPrimartFont(kPrimaryLightColor, 14, FontWeight.bold),
                ),
                Text(
                  "0xcff8...",
                  style: kPrimartFont(kPrimaryLightColor, 18, FontWeight.bold),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
