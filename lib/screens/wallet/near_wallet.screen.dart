import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/navigation/navigation_screen.dart';
import 'package:renderscan/common/components/buttons/button_type.dart';
import 'package:renderscan/theme/theme_provider.dart';
import 'package:renderscan/utils/storage.dart';

class NearWalletScreen extends StatefulWidget {
  final String privateKey;
  final String address;
  final String recoverUrl;
  final String pharse;

  NearWalletScreen(
      {required this.privateKey,
      required this.address,
      required this.recoverUrl,
      required this.pharse});

  @override
  State<NearWalletScreen> createState() => _NearWalletScreenState();
}

class _NearWalletScreenState extends State<NearWalletScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: AutoSizeText(
                "Save Credentials",
                textAlign: TextAlign.center,
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    18,
                    FontWeight.bold),
              ),
            ),
            centerTitle: true,
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
            backgroundColor:
                context.watch<ThemeProvider>().getBackgroundColor(),
          ),
          backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                KeyItem(keyText: "Private key", valueText: widget.privateKey),
                KeyItem(keyText: "Address", valueText: widget.address),
                KeyItem(keyText: "Pharse", valueText: widget.pharse),
                KeyItem(keyText: "Url", valueText: widget.recoverUrl),
                ButtonType(
                    type: "1",
                    text: "Next",
                    press: () async {
                      await Storage().setAddress(widget.address);
                      await Storage().setFirstTime(false);
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return NavigationScreen();
                      }));
                    })
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          )),
    );
  }
}

class KeyItem extends StatelessWidget {
  final String keyText;
  final String valueText;

  KeyItem({
    required this.keyText,
    required this.valueText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(children: [
            Container(
              child: AutoSizeText(
                keyText,
                textAlign: TextAlign.center,
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    16,
                    FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: valueText));
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: AutoSizeText(keyText + " copied!")));
              },
              child: Icon(
                FontAwesomeIcons.copy,
                size: 20,
                color: context.watch<ThemeProvider>().getHighLightColor(),
              ),
            )
          ]),
          SizedBox(
            height: 10,
          ),
          Container(
            child: AutoSizeText(
              valueText,
              textAlign: TextAlign.left,
              style: kPrimartFont(
                  context.watch<ThemeProvider>().getPriamryFontColor(),
                  12,
                  FontWeight.normal),
            ),
          )
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
    );
  }
}
