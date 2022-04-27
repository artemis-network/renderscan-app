import 'package:flutter/material.dart';
import 'package:renderscan/constants.dart';

class LoginButton extends StatefulWidget {
  final String text;
  final Function press;
  const LoginButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool _isElevated = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTapUp: (tu) {
        setState(() {
          _isElevated = !_isElevated;
        });
      },
      onTapDown: (td) {
        setState(() {
          _isElevated = !_isElevated;
        });
        widget.press();
      },
      child: AnimatedContainer(
        margin: EdgeInsets.all(10),
        duration: Duration(milliseconds: 100),
        padding: EdgeInsets.all(20),
        width: size.width * 0.6,
        decoration: BoxDecoration(
            color: kprimaryAuthBGColor,
            borderRadius: BorderRadius.circular(40),
            boxShadow: _isElevated
                ? [
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 2,
                        color: kprimaryNeuLight,
                        offset: Offset(-1, -1)),
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 8,
                        color: kprimaryNeuDark,
                        offset: Offset(5, 5)),
                  ]
                : [
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 2,
                        color: kprimaryNeuLight,
                        offset: Offset(1, 1)),
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 8,
                        color: kprimaryNeuDark,
                        offset: Offset(-5, -5)),
                  ]),
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: kPrimartFont(kPrimaryLightColor, 18, FontWeight.bold),
        ),
      ),
    );
  }
}
