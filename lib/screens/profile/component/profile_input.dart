import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/theme/theme_provider.dart';

class ProfileInput extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final String defaultValue;
  final Function onChange;

  ProfileInput(
      {Key? key,
      required this.labelText,
      required this.icon,
      required this.defaultValue,
      required this.onChange});

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
          onChanged: (e) => onChange(e),
          cursorColor: context.watch<ThemeProvider>().getPriamryFontColor(),
          initialValue: defaultValue,
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
