import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/common/components/buttons/button_type.dart';
import 'package:renderscan/screens/wallet/validation_wallet.screen.dart';
import 'package:renderscan/theme/theme_provider.dart';

class GenerateWalletScreen extends StatefulWidget {
  final String phrase;
  final String address;
  GenerateWalletScreen({required this.phrase, required this.address});
  @override
  State<GenerateWalletScreen> createState() => _GenerateWalletScreenState();
}

class _GenerateWalletScreenState extends State<GenerateWalletScreen> {
  List<String> pharseWordsList = [];

  Future<void> block() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  void initState() {
    block();
    setState(() {
      pharseWordsList = [...widget.phrase.split(" ")];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [],
        title: AutoSizeText(
          "Wallet Created",
          textAlign: TextAlign.center,
          style: kPrimartFont(
            context.watch<ThemeProvider>().getPriamryFontColor(),
            24,
            FontWeight.bold,
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
        backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      ),
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: AutoSizeText(
                      "Save them somewhere safe and never share them with anyone.",
                      textAlign: TextAlign.center,
                      style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        14,
                        FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Column(
                      children: [
                        AutoSizeText(
                          "Write down the secret recovery phrase.",
                          textAlign: TextAlign.center,
                          style: kPrimartFont(
                            context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            18,
                            FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.35, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: context
                                  .watch<ThemeProvider>()
                                  .getHighLightColor(),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  "Copy",
                                  textAlign: TextAlign.center,
                                  style: kPrimartFont(
                                    context
                                        .watch<ThemeProvider>()
                                        .getPriamryFontColor(),
                                    18,
                                    FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  "assets/icons/copy.png",
                                  height: 18,
                                  width: 18,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(vertical: 6),
                          ),
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: widget.phrase));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: AutoSizeText("phrase copied!")));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Expanded(
                  child: MasonryGridView.count(
                      itemCount: pharseWordsList.length,
                      crossAxisCount: 3,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: context
                                .watch<ThemeProvider>()
                                .getBackgroundColor(),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 2,
                                  color: context
                                      .watch<ThemeProvider>()
                                      .getHighLightColor())
                            ],
                          ),
                          child: AutoSizeText(
                            pharseWordsList[index],
                            textAlign: TextAlign.center,
                            style: kPrimartFont(
                              context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
                              18,
                              FontWeight.bold,
                            ),
                          ),
                        );
                      }),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: ButtonType(
                    type: "1",
                    text: "Proceed",
                    press: () {
                      var words = pharseWordsList;
                      words.shuffle();
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ValidationWalletScreen(
                          address: widget.address,
                          pharse: widget.phrase,
                          shuffled: words,
                        );
                      }));
                    }),
              )
            ]),
      ),
    ));
  }
}
