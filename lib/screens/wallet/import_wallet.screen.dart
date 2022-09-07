import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/navigation/navigation_screen.dart';
import 'package:renderscan/screens/wallet/wallet.api.dart';
import 'package:renderscan/theme/theme_provider.dart';
import 'package:renderscan/utils/storage.dart';

class ImportWalletScreen extends StatefulWidget {
  @override
  State<ImportWalletScreen> createState() => _ImportWalletScreenState();
}

class _ImportWalletScreenState extends State<ImportWalletScreen> {
  String mnemonic = "";

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
          child: Padding(
            child: Image.asset(
              "assets/icons/back.png",
              height: 24,
              width: 24,
            ),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          ),
        ),
        backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      ),
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      body: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            child: Text(
              "Enter phrase",
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
                  mnemonic = value;
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
          CreateWalletButton(
              text: "Recovery",
              press: () async {
                WalletApi.recoveryAddress(mnemonic).then((value) async {
                  await Storage().setAddress(value.address);
                  await Storage().setFirstTime(false);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return NavigationScreen();
                  }));
                });
              })
        ]),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      ),
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
