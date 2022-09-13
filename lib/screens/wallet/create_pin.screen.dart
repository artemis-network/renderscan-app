import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/common/components/buttons/button_type.dart';
import 'package:renderscan/screens/wallet/generate_wallet.screen.dart';
import 'package:renderscan/screens/wallet/wallet.api.dart';
import 'package:renderscan/theme/theme_provider.dart';

class CreatePinScreen extends StatefulWidget {
  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  List<String> confirmPin = ["", "", "", "", "", ""];
  List<String> currentPin = ["", "", "", "", "", ""];

  List<bool> buttonEffect = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<String> controls = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "X",
    "0",
    "Reset"
  ];
  bool isPinEntered = false;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      appBar: AppBar(
        centerTitle: true,
        title: AutoSizeText(
          "Create PIN",
          textAlign: TextAlign.center,
          style: kPrimartFont(
            context.watch<ThemeProvider>().getPriamryFontColor(),
            24,
            FontWeight.bold,
          ),
        ),
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
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxHeight == 768) {}
        return Column(children: [
          SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: AutoSizeText(
                  "This password will unlock only on this device",
                  textAlign: TextAlign.center,
                  style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    16,
                    FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: AutoSizeText(
                  isPinEntered ? "Confirm PIN" : "Enter PIN",
                  style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    14,
                    FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PinBox(message: currentPin[0], index: 1, count: count),
                  PinBox(message: currentPin[1], index: 2, count: count),
                  PinBox(message: currentPin[2], index: 3, count: count),
                  PinBox(message: currentPin[3], index: 4, count: count),
                  PinBox(message: currentPin[4], index: 5, count: count),
                  PinBox(message: currentPin[5], index: 6, count: count),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: MasonryGridView.count(
                physics: BouncingScrollPhysics(),
                crossAxisCount: 3,
                itemCount: controls.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: buttonEffect[index] ? 6 : 1,
                            color: context
                                .watch<ThemeProvider>()
                                .getHighLightColor(),
                          )
                        ],
                        color:
                            context.watch<ThemeProvider>().getBackgroundColor(),
                      ),
                      child: AutoSizeText(
                        controls[index],
                        textAlign: TextAlign.center,
                        style: kPrimartFont(
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                          28,
                          FontWeight.bold,
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        buttonEffect[index] = !buttonEffect[index];
                      });

                      if (count < 6 &&
                          index != 9 &&
                          index != 10 &&
                          index != 11) {
                        setState(() {
                          currentPin[count] = (index + 1).toString();
                          count += 1;
                        });
                      }

                      if (index == 9) {
                        if (count >= 0) {
                          setState(() {
                            currentPin[count - 1] = "";
                            count -= 1;
                          });
                        }
                      }

                      if (index == 10) {
                        if (count < 6) {
                          setState(() {
                            currentPin[count] = (0).toString();
                            count += 1;
                          });
                        }
                      }

                      if (index == 11) {
                        setState(() {
                          currentPin = ["", "", "", "", "", ""];
                          confirmPin = ["", "", "", "", "", ""];
                          isPinEntered = false;
                          count = 0;
                        });
                      }
                      var future =
                          Future.delayed(Duration(milliseconds: 250), () {
                        setState(() {
                          buttonEffect[index] = !buttonEffect[index];
                        });
                      });
                      future.then((value) => null);
                    },
                  );
                }),
          )),
          SizedBox(
            height: 10,
          ),
          Container(
            child: ButtonType(
                type: "1",
                text: "Submit",
                press: () {
                  if (count == 6) {
                    if (!isPinEntered) {
                      setState(() {
                        isPinEntered = true;
                        confirmPin = currentPin;
                        currentPin = ["", "", "", "", "", ""];
                        count = 0;
                      });
                    } else {
                      if (!listEquals(confirmPin, currentPin)) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: AutoSizeText(
                          "Pin does not match",
                          style: kPrimartFont(
                            Colors.amber,
                            18,
                            FontWeight.bold,
                          ),
                        )));
                      } else {
                        var pin = "";
                        for (int i = 0; i < confirmPin.length; i++) {
                          pin += confirmPin[i];
                        }
                        WalletApi.createEthWalletAddress(pin)
                            .then((value) => {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: ((context) {
                                    return GenerateWalletScreen(
                                        phrase: value.mnemonic,
                                        address: value.address);
                                  })))
                                })
                            .catchError((err) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: AutoSizeText(
                            "Something went wrong try again later",
                            style: kPrimartFont(
                              Colors.amber,
                              18,
                              FontWeight.bold,
                            ),
                          )));
                        });
                      }
                    }
                  }
                }),
          ),
          SizedBox(
            height: 20,
          ),
        ]);
      }),
    );
  }
}

class PinBox extends StatelessWidget {
  final String message;
  final int count;
  final int index;

  PinBox({required this.message, required this.count, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(minHeight: 50, minWidth: 40),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: context.watch<ThemeProvider>().getPriamryFontColor(),
      ),
      child: AutoSizeText(
        message,
        textAlign: TextAlign.center,
        style: kPrimartFont(
          context.watch<ThemeProvider>().getBackgroundColor(),
          30,
          FontWeight.bold,
        ),
      ),
    );
  }
}
