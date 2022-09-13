import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/common/components/buttons/button_type.dart';
import 'package:renderscan/screens/wallet/create_near_wallet.screen.dart';
import 'package:renderscan/screens/wallet/create_pin.screen.dart';
import 'package:renderscan/screens/wallet/import_wallet.screen.dart';
import 'package:renderscan/screens/wallet/view_near_wallet.screen.dart';
import 'package:renderscan/theme/theme_provider.dart';

class CreateWalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 40,
              ),
              Image.asset(
                "assets/images/wallet.png",
                height: 165,
                width: 165,
              ),
              Column(
                children: [
                  ButtonType(
                      type: "1",
                      text: "Create ETH Wallet",
                      press: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => CreatePinScreen())));
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => ImportWalletScreen())));
                    },
                    child: AutoSizeText(
                      "Import eth wallet using secret recovery phrase",
                      textAlign: TextAlign.center,
                      style: kPrimartFont(
                        context.watch<ThemeProvider>().getHighLightColor(),
                        14,
                        FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      height: 3,
                      thickness: 3,
                      color: context.watch<ThemeProvider>().getHighLightColor(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    color: context.watch<ThemeProvider>().getBackgroundColor(),
                    child: AutoSizeText(
                      "OR",
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                          18,
                          FontWeight.bold),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  ButtonType(
                      type: "1",
                      text: "Create NEAR Wallet",
                      press: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => CreateNearWalletScreen())));
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => ViewNearWallerScreen())));
                    },
                    child: AutoSizeText(
                      "Import eth wallet using secret recovery phrase",
                      textAlign: TextAlign.center,
                      style: kPrimartFont(
                        context.watch<ThemeProvider>().getHighLightColor(),
                        14,
                        FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ]),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    ));
  }
}
