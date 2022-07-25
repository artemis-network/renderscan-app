import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/transistion_screen/welcome/slides/slide_two.dart';

class SlideOne extends StatefulWidget {
  @override
  State<SlideOne> createState() => _SlideOneState();
}

class _SlideOneState extends State<SlideOne> {
  final buttonState = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    setStateButton(int index) {
      bool current = !buttonState[index];
      setState(() {
        buttonState[index] = current;
      });
    }

    return SafeArea(
        child: Scaffold(
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 50),
        child: Column(children: [
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
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            children: [
              Selector(
                  sub: Icons.abc_outlined,
                  selected: buttonState[0],
                  text: "Play NFT Games",
                  onClick: () => setStateButton(0),
                  main: Icons.cast_sharp),
              Selector(
                  sub: Icons.abc_outlined,
                  selected: buttonState[1],
                  text: "Trade NFTs",
                  onClick: () => setStateButton(1),
                  main: Icons.cast_sharp),
              Selector(
                  sub: Icons.abc_outlined,
                  selected: buttonState[2],
                  text: "Create & Sell NFTs",
                  onClick: () => setStateButton(2),
                  main: Icons.cast_sharp),
              Selector(
                  sub: Icons.abc_outlined,
                  onClick: () => setStateButton(3),
                  selected: buttonState[3],
                  text: "Buy Unique NFTs",
                  main: Icons.cast_sharp)
            ],
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(PageTransition(
                    type: PageTransitionType.leftToRight,
                    child: SlideTwo(),
                    ctx: context,
                    duration: Duration(milliseconds: 300),
                    fullscreenDialog: true,
                    childCurrent: SlideOne()));
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: context.watch<ThemeProvider>().getBackgroundColor(),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color: context
                              .watch<ThemeProvider>()
                              .getHighLightColor())
                    ]),
                alignment: Alignment.center,
                child: Text("Next",
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        34,
                        FontWeight.bold)),
              )),
        ]),
      ),
    ));
  }
}

class Selector extends StatefulWidget {
  final bool selected;
  final String text;
  final IconData main;
  final IconData sub;
  final Function onClick;

  Selector(
      {required this.sub,
      required this.onClick,
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
            color: context.watch<ThemeProvider>().getBackgroundColor(),
            boxShadow: [
              BoxShadow(
                  blurRadius: 8,
                  color: !widget.selected
                      ? context.watch<ThemeProvider>().getPriamryFontColor()
                      : context.watch<ThemeProvider>().getHighLightColor())
            ]),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 00),
        duration: Duration(milliseconds: 400),
        alignment: Alignment.center,
        child: Row(
          children: [
            SizedBox(
              width: 18,
            ),
            Row(
              children: [
                Icon(Icons.abc,
                    size: 30,
                    color:
                        context.watch<ThemeProvider>().getPriamryFontColor()),
                Text(" + ",
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        18,
                        FontWeight.bold)),
                Icon(Icons.abc,
                    size: 30,
                    color:
                        context.watch<ThemeProvider>().getPriamryFontColor()),
              ],
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
                      context.watch<ThemeProvider>().getPriamryFontColor(),
                      14,
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
