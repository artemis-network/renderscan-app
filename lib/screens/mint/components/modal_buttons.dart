import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/theme/theme_provider.dart';

class ModalButton extends StatelessWidget {
  final String text;
  final Function onClick;
  final String color;

  ModalButton(
      {Key? key,
      required this.text,
      required this.onClick,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      onClick();
                    },
                    child: Text(
                      text,
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getBackgroundColor(),
                          14,
                          FontWeight.bold),
                    )),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    onClick();
                  },
                  child: color == "primary"
                      ? Icon(
                          Icons.bolt_rounded,
                          color: Colors.white,
                          size: 18,
                        )
                      : Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color:
                    color == "primary" ? Colors.greenAccent : Colors.redAccent,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 100,
                      color: context
                          .watch<ThemeProvider>()
                          .getHighLightColor()
                          .withOpacity(0.66),
                      offset: Offset(0, 0)),
                ]),
          )),
    );
  }
}
