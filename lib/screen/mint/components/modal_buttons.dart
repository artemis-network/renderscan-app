import 'package:flutter/material.dart';
import 'package:renderscan/constants.dart';

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
                    onTap: () {},
                    child: Text(
                      text,
                      style:
                          kPrimartFont(kPrimaryLightColor, 14, FontWeight.bold),
                    )),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {},
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
                      spreadRadius: 1,
                      blurRadius: 2,
                      color: kprimaryAuthBGColor,
                      offset: Offset(1, 1)),
                ]),
          )),
    );
  }
}
