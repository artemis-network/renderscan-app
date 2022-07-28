import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';

class ProfileInput extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final TextEditingController controller;

  ProfileInput(
      {Key? key,
      required this.labelText,
      required this.icon,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        decoration: BoxDecoration(
            color: context.watch<ThemeProvider>().getBackgroundColor(),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 100,
                  color: context
                      .watch<ThemeProvider>()
                      .getHighLightColor()
                      .withOpacity(0.22),
                  offset: Offset(0, 0)),
            ]),
        child: TextFormField(
          readOnly: true,
          enabled: false,
          cursorColor: kPrimaryLightColor,
          controller: controller,
          style: GoogleFonts.poppins(
            decoration: TextDecoration.none,
            decorationThickness: 0,
            decorationColor: context
                .watch<ThemeProvider>()
                .getSecondaryFontColor()
                .withOpacity(0.0),
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: context.watch<ThemeProvider>().getSecondaryFontColor(),
          ),
          decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: context.watch<ThemeProvider>().getSecondaryFontColor(),
              ),
              label: Text(
                labelText,
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getSecondaryFontColor(),
                    16,
                    FontWeight.normal),
                maxLines: 1,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none),
        ),
      ),
    );
  }
}
