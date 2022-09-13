import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/loader.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/common/components/buttons/button_type.dart';
import 'package:renderscan/screens/wallet/near_wallet.screen.dart';
import 'package:renderscan/screens/wallet/wallet.api.dart';
import 'package:renderscan/theme/theme_provider.dart';
import 'package:renderscan/utils/storage.dart';

class ViewNearWallerScreen extends StatefulWidget {
  @override
  State<ViewNearWallerScreen> createState() => _ViewNearWallerScreenState();
}

class _ViewNearWallerScreenState extends State<ViewNearWallerScreen> {
  String privatekey = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var style = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          width: 2,
          color: context.watch<ThemeProvider>().getFavouriteColor(),
          style: BorderStyle.solid,
        ));

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            child: Image.asset(
              "assets/icons/back.png",
              height: 24,
              width: 24,
            ),
            margin: EdgeInsets.only(left: 18),
          ),
        ),
        backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      ),
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      body: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            child: AutoSizeText(
              "Enter passphrase ",
              style: kPrimartFont(
                  context.watch<ThemeProvider>().getPriamryFontColor(),
                  18,
                  FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
              onChanged: (value) {
                setState(() {
                  privatekey = value;
                });
              },
              style: kPrimartFont(
                  context.watch<ThemeProvider>().getHighLightColor(),
                  24,
                  FontWeight.bold),
              decoration: InputDecoration(
                focusColor: context.watch<ThemeProvider>().getFavouriteColor(),
                focusedBorder: style,
                enabledBorder: style,
              )),
          SizedBox(
            height: 20,
          ),
          !isLoading
              ? ButtonType(
                  type: "1",
                  text: "Recover Wallet",
                  press: () async {
                    setState(() {
                      isLoading = true;
                    });
                    WalletApi.recoveryNeartWalletAddress(privatekey)
                        .then((value) async {
                      await Storage().setAddress(value.address);
                      await Storage().setFirstTime(false);
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return NearWalletScreen(
                          address: value.address,
                          pharse: value.mnemonic,
                          privateKey: value.privateKey,
                          recoverUrl: value.recoverUrl,
                        );
                      }));
                    });
                  })
              : spinkit()
        ]),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      ),
    ));
  }
}
