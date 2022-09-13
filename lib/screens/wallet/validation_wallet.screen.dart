import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/navigation/navigation_screen.dart';
import 'package:renderscan/common/components/buttons/button_type.dart';
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

  List<int> order = [];

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
        centerTitle: true,
        title: AutoSizeText(
          "Confirm Phrase",
          style: kPrimartFont(
            context.watch<ThemeProvider>().getPriamryFontColor(),
            24,
            FontWeight.bold,
          ),
        ),
        actions: [],
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
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      child: AutoSizeText(
                        "Tap the words to put them next to each other in correct order",
                        textAlign: TextAlign.center,
                        style: kPrimartFont(
                            context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            14,
                            FontWeight.normal),
                      ),
                    )
                  ],
                ),
                Expanded(
                    child: Container(
                  child: MasonryGridView.count(
                      crossAxisCount: 3,
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                          child: AutoSizeText(
                            value[index],
                            textAlign: TextAlign.center,
                            style: kPrimartFont(
                                context
                                    .watch<ThemeProvider>()
                                    .getBackgroundColor(),
                                20,
                                FontWeight.bold),
                          ),
                        );
                      }),
                )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          List<int> o = order;
                          if (o.length > 0) {
                            setState(() {
                              value[count - 1] = "";
                              isSelected[o[o.length - 1]] = false;
                              count -= 1;
                            });
                            o.removeLast();
                            setState(() {
                              order = o;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: context
                                  .watch<ThemeProvider>()
                                  .getBackgroundColor(),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5,
                                    color: context
                                        .watch<ThemeProvider>()
                                        .getHighLightColor())
                              ]),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: AutoSizeText(
                            "Delete",
                            style: kPrimartFont(
                                context
                                    .watch<ThemeProvider>()
                                    .getPriamryFontColor(),
                                18,
                                FontWeight.bold),
                          ),
                        ),
                      ),
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
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: context
                                  .watch<ThemeProvider>()
                                  .getBackgroundColor(),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5,
                                    color: context
                                        .watch<ThemeProvider>()
                                        .getHighLightColor())
                              ]),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                ),
                Expanded(
                    child: Container(
                  child: MasonryGridView.count(
                      crossAxisCount: 3,
                      itemCount: widget.shuffled.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (count < 12 && isSelected[index] != true) {
                              List<int> o = order;
                              o.add(index);
                              print(o);
                              setState(() {
                                value[count] = widget.shuffled[index];
                                isSelected[index] = true;
                                order = o;
                                count += 1;
                              });
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
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
                            child: AutoSizeText(
                              widget.shuffled[index],
                              textAlign: TextAlign.center,
                              style: kPrimartFont(
                                  context
                                      .watch<ThemeProvider>()
                                      .getPriamryFontColor(),
                                  20,
                                  FontWeight.bold),
                            ),
                          ),
                        );
                      }),
                  padding: EdgeInsets.symmetric(vertical: 12),
                )),
                ButtonType(
                    type: "1",
                    text: "Confirm",
                    press: () async {
                      String pharse = "";
                      for (int i = 0; i < value.length; i++)
                        pharse += value[i] + " ";

                      if (widget.pharse.trim() == pharse.trim()) {
                        final String address = "0x" + widget.address;
                        Storage().setAddress(address).then((value) async {
                          await Storage().setFirstTime(false);
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return NavigationScreen();
                          }));
                        });
                      } else
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: AutoSizeText(
                          "Invalid pharse retry!",
                          style:
                              kPrimartFont(Colors.amber, 18, FontWeight.bold),
                        )));
                    })
              ])),
    ));
  }
}
