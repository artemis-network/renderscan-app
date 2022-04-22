import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var kPrimaryColor = Color(0xfff4D77FF);
var kprimaryBackGroundColor = Colors.black;
var kPrimaryLightColor = Colors.white70;

var kPrimaryShadow = kPrimaryColor.withOpacity(1);

kPrimartFont(Color? color, double? fontSize, FontWeight? weight) {
  return GoogleFonts.poppins(
    color: color,
    fontSize: fontSize,
    fontWeight: weight,
  );
}

kSecondaryFont(
    Color color, Color backgruond, double fontSize, FontWeight weight) {
  return GoogleFonts.oswald(
    color: color,
    backgroundColor: backgruond,
    fontSize: fontSize,
    fontWeight: weight,
  );
}
