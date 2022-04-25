import 'package:flutter/material.dart';
import 'package:renderscan/constants.dart';

class InputField extends StatelessWidget {
  String hintText;
  String labelText;
  IconData icon;
  Function onChange;

  InputField(
      {Key? key,
      required this.hintText,
      required this.labelText,
      required this.icon,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        decoration: BoxDecoration(
            color: kprimaryAuthNeuFGColor,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                  spreadRadius: -5,
                  blurRadius: 8,
                  color: kprimaryAuthNeuDarkColor,
                  offset: Offset(-5, -5)),
              BoxShadow(
                  spreadRadius: -2,
                  blurRadius: 4,
                  color: kprimaryAuthNeuLightColor,
                  offset: Offset(1, 1)),
            ]),
        child: TextField(
          onChanged: (value) => onChange(value),
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: kPrimaryLightColor,
              ),
              hintText: hintText,
              hintStyle:
                  kPrimartFont(kPrimaryLightColor, 14, FontWeight.normal),
              label: Text(
                labelText,
                style: kPrimartFont(kPrimaryLightColor, 16, FontWeight.normal),
              ),
              border: InputBorder.none),
        ),
      ),
    );
  }
}
