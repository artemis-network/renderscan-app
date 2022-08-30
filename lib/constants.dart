import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

kPrimartFont(Color? color, double? fontSize, FontWeight? weight) {
  return GoogleFonts.quicksand(
    color: color,
    fontSize: fontSize,
    fontWeight: weight,
  );
}

kSecondaryFont(
    Color color, Color backgruond, double fontSize, FontWeight weight) {
  return GoogleFonts.mouseMemoirs(
    color: color,
    backgroundColor: backgruond,
    fontSize: fontSize,
    fontWeight: weight,
  );
}
