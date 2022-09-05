import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/wallet/create_pin.screen.dart';
import 'package:renderscan/screens/wallet/import_wallet.screen.dart';
import 'package:renderscan/theme/theme_provider.dart';

class CreateWalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          "assets/images/wallet.png",
          height: 165,
          width: 165,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(children: [
            Container(
                child: Text(
              "○ Create a wallet with a secret phase recovery",
              textAlign: TextAlign.center,
              style: kPrimartFont(
                context.watch<ThemeProvider>().getPriamryFontColor(),
                14,
                FontWeight.bold,
              ),
            )),
            Container(
                child: Text(
              "○ This is secure web3 wallet that will be used to store NFT's and Earnings",
              textAlign: TextAlign.center,
              style: kPrimartFont(
                context.watch<ThemeProvider>().getPriamryFontColor(),
                14,
                FontWeight.bold,
              ),
            ))
          ]),
        ),
        SizedBox(
          height: 20,
        ),
        CreateWalletButton(
            text: "Create Wallet",
            press: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: ((context) => CreatePinScreen())));
            }),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => ImportWalletScreen())));
          },
          child: Text(
            "Recovery address with recovery phrase",
            textAlign: TextAlign.center,
            style: kPrimartFont(
              context.watch<ThemeProvider>().getPriamryFontColor(),
              18,
              FontWeight.bold,
            ),
          ),
        )
      ]),
    ));
  }
}

class CreateWalletButton extends StatelessWidget {
  final String text;
  final Function press;
  const CreateWalletButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        press();
      },
      child: Container(
        padding: EdgeInsets.all(20),
        width: size.width * 0.8,
        decoration: BoxDecoration(
            color: context.watch<ThemeProvider>().getHighLightColor(),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 2,
                  color: context.watch<ThemeProvider>().getHighLightColor(),
                  offset: Offset(0, 0)),
            ]),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: kPrimartFont(Colors.white, 24, FontWeight.bold),
        ),
      ),
    );
  }
}
