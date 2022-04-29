import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:renderscan/constants.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final Function onChange;

  InputField(
      {Key? key,
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
          cursorColor: kPrimaryLightColor,
          style: GoogleFonts.poppins(
              decoration: TextDecoration.none,
              decorationThickness: 0,
              decorationColor: kprimaryAuthNeuFGColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: kPrimaryLightColor),
          decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: kPrimaryLightColor,
              ),
              label: Text(
                labelText,
                style: kPrimartFont(kPrimaryLightColor, 16, FontWeight.normal),
                maxLines: 1,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none),
        ),
      ),
    );
  }
}
