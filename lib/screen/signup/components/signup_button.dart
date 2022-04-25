import 'package:flutter/material.dart';
import 'package:renderscan/constants.dart';

class SignUpButton extends StatelessWidget {
  final String text;
  final Function press;
  const SignUpButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.all(10),
        width: size.width * 0.6,
        decoration: BoxDecoration(
            color: Color(0xff290A5C),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
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
            ]),
        child: TextButton(
          child: Text(
            text,
            style: kPrimartFont(kPrimaryLightColor, 18, FontWeight.bold),
          ),
          onPressed: () => press(),
        ));
  }
}
