import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/welcome/slides/slides.dart';
import 'package:renderscan/theme/theme_provider.dart';

class GettingStarted extends StatefulWidget {
  @override
  State<GettingStarted> createState() => _GettingStartedState();
}

class _GettingStartedState extends State<GettingStarted> {
  final buttonState = [false, false, false, false];
  bool buttonEffect = false;

  @override
  Widget build(BuildContext context) {
    setStateButton(int index) {
      bool current = !buttonState[index];
      setState(() {
        buttonState[index] = current;
      });
    }

    return Scaffold(
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.symmetric(vertical: 50),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Text(
                    "You want to...",
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        22,
                        FontWeight.bold),
                  ),
                  Text(
                    "(Select all that apply)",
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        16,
                        FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Selector(
                      selected: buttonState[0],
                      text: "Create + Design NFTs",
                      onClick: () => setStateButton(0),
                      main: "assets/images/create_design.png"),
                  Selector(
                      selected: buttonState[1],
                      text: "Import + Mint NFTs",
                      onClick: () => setStateButton(1),
                      main: "assets/images/import_mint.png"),
                  Selector(
                      selected: buttonState[2],
                      text: "Buy & Sell NFTs",
                      onClick: () => setStateButton(2),
                      main: "assets/images/buy_sell.png"),
                  Selector(
                      onClick: () => setStateButton(3),
                      selected: buttonState[3],
                      text: "Remove Background",
                      main: "assets/images/no_bg.png")
                ],
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      buttonEffect = !buttonEffect;
                    });
                    var future = Future.delayed(
                        const Duration(milliseconds: 250), () async {
                      setState(() {
                        buttonEffect = !buttonEffect;
                      });
                      Navigator.of(context).push(PageTransition(
                          type: PageTransitionType.leftToRight,
                          child: Slides(),
                          ctx: context,
                          duration: Duration(milliseconds: 150),
                          fullscreenDialog: true,
                          childCurrent: GettingStarted()));
                    });
                    future.then((value) {});
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 150),
                    margin: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:
                            context.watch<ThemeProvider>().getBackgroundColor(),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: buttonEffect ? 30 : 10,
                              color: context
                                  .watch<ThemeProvider>()
                                  .getHighLightColor())
                        ]),
                    alignment: Alignment.center,
                    child: Text("Get Started",
                        style: kPrimartFont(
                            buttonEffect
                                ? context
                                    .watch<ThemeProvider>()
                                    .getHighLightColor()
                                : context
                                    .watch<ThemeProvider>()
                                    .getPriamryFontColor(),
                            34,
                            FontWeight.bold)),
                  )),
            ]),
      )),
    );
  }
}

class Selector extends StatefulWidget {
  final bool selected;
  final String text;
  final String main;
  final Function onClick;

  Selector(
      {required this.onClick,
      required this.selected,
      required this.text,
      required this.main});

  @override
  State<Selector> createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onClick(),
      child: AnimatedContainer(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: !widget.selected
                ? context.watch<ThemeProvider>().getBackgroundColor()
                : context.watch<ThemeProvider>().getHighLightColor(),
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                color: context.watch<ThemeProvider>().getHighLightColor(),
              )
            ]),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        duration: Duration(milliseconds: 400),
        alignment: Alignment.center,
        child: Row(
          children: [
            SizedBox(
              width: 0,
            ),
            Image.asset(
              widget.main,
              height: 48,
              width: 48,
            ),
            SizedBox(
              width: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.text,
                  style: kPrimartFont(
                      widget.selected
                          ? context.watch<ThemeProvider>().getPriamryFontColor()
                          : context.watch<ThemeProvider>().getHighLightColor(),
                      18,
                      FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
