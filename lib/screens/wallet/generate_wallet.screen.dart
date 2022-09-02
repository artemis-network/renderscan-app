
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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

  @override
  void initState() {
    setState(() {
      pharseWordsList = [...widget.phrase.split(" ")];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(actions: []),
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
                  Container(
                    child: Text(
                      "This 12 word secret pharse in the text order mentioned below is the only way to restore your wallet in case you login from another device",
                      textAlign: TextAlign.center,
                      style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        16,
                        FontWeight.bold,
                      ),
                    ),
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
                    height: 40,
                  ),
                  Container(
                    child: Text(
                      "Write down the secret recovery phrase.",
                      textAlign: TextAlign.center,
                      style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        20,
                        FontWeight.bold,
                      ),
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
