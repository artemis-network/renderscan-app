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
            color: context.watch<ThemeProvider>().getHighLightColor(),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                  spreadRadius: -5,
                  blurRadius: 8,
                  color: context.watch<ThemeProvider>().getHighLightColor(),
                  offset: Offset(-5, -5)),
              BoxShadow(
                  spreadRadius: -2,
                  blurRadius: 4,
                  color: context.watch<ThemeProvider>().getHighLightColor(),
                  offset: Offset(1, 1)),
            ]),
        child: TextField(
          onChanged: (value) => onChange(value),
          cursorColor: context.watch<ThemeProvider>().getHighLightColor(),
          style: GoogleFonts.poppins(
              decoration: TextDecoration.none,
              decorationThickness: 0,
              decorationColor:
                  context.watch<ThemeProvider>().getHighLightColor(),
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: context.watch<ThemeProvider>().getFavouriteColor()),
          decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: context.watch<ThemeProvider>().getFavouriteColor(),
              ),
              label: Text(
                labelText,
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getFavouriteColor(),
                    15,
                    FontWeight.normal),
                maxLines: 1,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15)),
        ),
      ),
    );
  }
}
