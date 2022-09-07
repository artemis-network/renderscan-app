import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
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
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
        backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      ),
      body: Column(children: [
        SizedBox(
          height: 30,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                "Create PIN",
                textAlign: TextAlign.center,
                style: kPrimartFont(
                  context.watch<ThemeProvider>().getPriamryFontColor(),
                  22,
                  FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
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
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
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
                          blurRadius: 2,
                          color: context
                              .watch<ThemeProvider>()
                              .getPriamryFontColor(),
                        )
                      ],
                      color: context.watch<ThemeProvider>().getHighLightColor(),
                    ),
                    child: Text(
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
                    if (count < 6 && index != 9 && index != 10 && index != 11) {
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
                  },
                );
              }),
        )),
        SizedBox(
          height: 20,
        ),
        Container(
          child: CreateWalletButton(
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
                          content: Text(
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
                      WalletApi.createAddress(pin)
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
                            content: Text(
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
          height: 30,
        ),
      ]),
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
      child: Text(
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

class CreateWalletButton extends StatefulWidget {
  final String text;
  final Function press;
  const CreateWalletButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  State<CreateWalletButton> createState() => _CreateWalletButtonState();
}

class _CreateWalletButtonState extends State<CreateWalletButton> {
  bool buttonEffect = false;
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            buttonEffect = !buttonEffect;
          });
          var future = Future.delayed(Duration(milliseconds: 150), () {
            setState(() {
              buttonEffect = !buttonEffect;
            });
            widget.press();
          });
          future.then((value) {});
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 150),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: context.watch<ThemeProvider>().getHighLightColor(),
              boxShadow: [
                BoxShadow(
                    blurRadius: buttonEffect ? 30 : 10,
                    color: context.watch<ThemeProvider>().getHighLightColor())
              ]),
          alignment: Alignment.center,
          child: Text(widget.text,
              style: kPrimartFont(
                  context.watch<ThemeProvider>().getPriamryFontColor(),
                  34,
                  FontWeight.bold)),
        ));
  }
}
