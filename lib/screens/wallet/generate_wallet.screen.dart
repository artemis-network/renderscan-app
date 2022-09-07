import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
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
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [],
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
                    child: Text(
                      "Your wallet is successfully created",
                      textAlign: TextAlign.center,
                      style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        20,
                        FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      "Save them somewhere safe and never share them with anyone.",
                      textAlign: TextAlign.center,
                      style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        16,
                        FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "Write down the secret recovery phrase.",
                          textAlign: TextAlign.center,
                          style: kPrimartFont(
                            context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            20,
                            FontWeight.bold,
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Copy",
                                textAlign: TextAlign.center,
                                style: kPrimartFont(
                                  context
                                      .watch<ThemeProvider>()
                                      .getPriamryFontColor(),
                                  20,
                                  FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                child: Image.asset(
                                  "assets/icons/copy.png",
                                  height: 18,
                                  width: 18,
                                ),
                                onTap: () {
                                  Clipboard.setData(
                                      ClipboardData(text: widget.phrase));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("phrase copied!")));
                                },
                              )
                            ],
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Expanded(
                  child: MasonryGridView.count(
                      itemCount: pharseWordsList.length,
                      crossAxisCount: 3,
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
                          child: Text(
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
                margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: CreateWalletButton(
                    text: "Procced",
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
