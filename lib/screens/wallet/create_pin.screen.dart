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
  List<String> controls = ["X", "0", "Reset"];
  bool isPinEntered = false;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      appBar: AppBar(
        actions: [],
        backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      ),
      body: Column(children: [
        Column(
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
              height: 10,
            ),
            Container(
              child: Text(
                "This password will unlock only on this device",
                textAlign: TextAlign.center,
                style: kPrimartFont(
                  context.watch<ThemeProvider>().getPriamryFontColor(),
                  18,
                  FontWeight.normal,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
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
          height: 40,
        ),
        Expanded(
            child: Column(
          children: [
            Expanded(
                child: MasonryGridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                color: context
                                    .watch<ThemeProvider>()
                                    .getPriamryFontColor(),
                              )
                            ],
                            color: context
                                .watch<ThemeProvider>()
                                .getBackgroundColor(),
                          ),
                          child: Text(
                            (index + 1).toString(),
                            textAlign: TextAlign.center,
                            style: kPrimartFont(
                              context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
                              28,
                              FontWeight.bold,
                            ),
                          ),
                        ),
                        onTap: () {
                          if (count < 6) {
                            setState(() {
                              currentPin[count] = (index + 1).toString();
                              count += 1;
                            });
                          }
                        },
                      );
                    })),
            Expanded(
                child: MasonryGridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                            color: context
                                .watch<ThemeProvider>()
                                .getBackgroundColor(),
                          ),
                          child: Text(
                            controls[index],
                            textAlign: TextAlign.center,
                            style: kPrimartFont(
                              context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
                              28,
                              FontWeight.bold,
                            ),
                          ),
                        ),
                        onTap: () {
                          if (index == 0) {
                            if (count >= 0) {
                              setState(() {
                                currentPin[count - 1] = "";
                                count -= 1;
                              });
                            }
                          }

                          if (index == 1) {
                            if (count < 6) {
                              setState(() {
                                currentPin[count] = (0).toString();
                                count += 1;
                              });
                            }
                          }

                          if (index == 2) {
                            setState(() {
                              currentPin = ["", "", "", "", "", ""];
                              confirmPin = ["", "", "", "", "", ""];
                              isPinEntered = false;
                              count = 0;
                            });
                          }
                        },
                      );
                    })),
          ],
        )),
        Container(
          margin: EdgeInsets.only(bottom: 40),
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
                    print(confirmPin.toString());
                    print(currentPin.toString());
                    print(confirmPin.toString() != currentPin.toString());
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
        )
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
    return OutlinedButton(
      onPressed: () => press(),
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
