import 'package:flutter/material.dart';
import 'package:renderscan/constants.dart';

class ActivateButton extends StatefulWidget {
  final String text;
  final Function press;
  const ActivateButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  State<ActivateButton> createState() => _ActivateButtonState();
}

class _ActivateButtonState extends State<ActivateButton> {
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
        duration: Duration(microseconds: 250),
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