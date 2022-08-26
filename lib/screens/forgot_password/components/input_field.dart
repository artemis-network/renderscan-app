import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/theme/theme_provider.dart';

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
            color: context.watch<ThemeProvider>().getBackgroundColor(),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 1,
                  color: context.watch<ThemeProvider>().getFavouriteColor(),
                  offset: Offset(0, 0)),
            ]),
        child: TextField(
          onChanged: (value) => onChange(value),
          cursorColor: context.watch<ThemeProvider>().getPriamryFontColor(),
          style: GoogleFonts.poppins(
            decoration: TextDecoration.none,
            decorationThickness: 0,
            decorationColor: context
                .watch<ThemeProvider>()
                .getPriamryFontColor()
                .withOpacity(0.0),
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: context.watch<ThemeProvider>().getPriamryFontColor(),
          ),
          decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: context.watch<ThemeProvider>().getPriamryFontColor(),
              ),
              label: Text(
                labelText,
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    18,
                    FontWeight.bold),
                maxLines: 1,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none),
        ),
      ),
    );
  }
}
