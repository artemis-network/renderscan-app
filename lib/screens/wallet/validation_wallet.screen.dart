import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/navigation/navigation_screen.dart';
import 'package:renderscan/theme/theme_provider.dart';
import 'package:renderscan/utils/storage.dart';

class ValidationWalletScreen extends StatefulWidget {
  final String address;
  final List<String> shuffled;
  final String pharse;

  ValidationWalletScreen(
      {required this.address, required this.shuffled, required this.pharse});

  @override
  State<ValidationWalletScreen> createState() => _ValidationWalletScreenState();
}

class _ValidationWalletScreenState extends State<ValidationWalletScreen> {
  List<bool> isSelected = [
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
    false,
  ];

  List<String> value = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  ];

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [],
      ),
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      child: Text(
                        "Confirm your secret recovery phrase",
                        style: kPrimartFont(
                          context.watch<ThemeProvider>().getPriamryFontColor(),
                          18,
                          FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        "Tap the words to put them next to each other in correct order",
                        textAlign: TextAlign.center,
                        style: kPrimartFont(
                            context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            18,
                            FontWeight.normal),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: MasonryGridView.count(
                        crossAxisCount: 3,
                        itemCount: 12,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                color: context
                                    .watch<ThemeProvider>()
                                    .getPriamryFontColor(),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 2,
                                      color: context
                                          .watch<ThemeProvider>()
                                          .getHighLightColor())
                                ]),
                            alignment: Alignment.center,
                            child: Text(
                              value[index],
                              textAlign: TextAlign.center,
                              style: kPrimartFont(
                                  context
                                      .watch<ThemeProvider>()
                                      .getBackgroundColor(),
                                  18,
                                  FontWeight.bold),
                            ),
                          );
                        })),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          count = 0;
                          value = [
                            "",
                            "",
                            "",
                            "",
                            "",
                            "",
                            "",
                            "",
                            "",
                            "",
                            "",
                            ""
                          ];
                          isSelected = [
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
                            false,
                          ];
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Text(
                          "Reset",
                          style: kPrimartFont(
                              context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
                              18,
                              FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                    child: MasonryGridView.count(
                        crossAxisCount: 3,
                        itemCount: widget.shuffled.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (count < 12 && isSelected[index] != true) {
                                setState(() {
                                  value[count] = widget.shuffled[index];
                                  isSelected[index] = true;
                                  count += 1;
                                });
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                  color: isSelected[index]
                                      ? context
                                          .watch<ThemeProvider>()
                                          .getBackgroundColor()
                                      : context
                                          .watch<ThemeProvider>()
                                          .getHighLightColor(),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2,
                                        color: context
                                            .watch<ThemeProvider>()
                                            .getHighLightColor())
                                  ]),
                              alignment: Alignment.center,
                              child: Text(
                                widget.shuffled[index],
                                textAlign: TextAlign.center,
                                style: kPrimartFont(
                                    context
                                        .watch<ThemeProvider>()
                                        .getPriamryFontColor(),
                                    18,
                                    FontWeight.bold),
                              ),
                            ),
                          );
                        })),
                CreateWalletButton(
                    text: "Confirm",
                    press: () {
                      String pharse = "";
                      for (int i = 0; i < value.length; i++)
                        pharse += value[i] + " ";

                      if (widget.pharse.trim() == pharse.trim()) {
                        Storage()
                            .setAddress(widget.address)
                            .then((value) async {
                          await Storage().setFirstTime(false);
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return NavigationScreen();
                          }));
                        });
                      } else
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          "Invalid pharse retry!",
                          style:
                              kPrimartFont(Colors.amber, 18, FontWeight.bold),
                        )));
                    })
              ])),
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
