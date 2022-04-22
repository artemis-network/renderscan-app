import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var kPrimaryColor = Color(0xff0F0326);
var kprimaryBackGroundColor = kPrimaryColor;
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

var kprimaryNeuDark = Color(0xff080213).withOpacity(0.5);
var kprimaryNeuLight = Color(0xff5D18DC).withOpacity(0.5);
var kprimaryLoaderColor = Color(0xff170538).withOpacity(0.8);
var kprimaryBottomBarColor = Color(0xff170538);
