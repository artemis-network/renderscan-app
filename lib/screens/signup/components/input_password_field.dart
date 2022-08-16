import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/theme/theme_provider.dart';

class InputPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String text;

  const InputPasswordField({
    Key? key,
    required this.text,
    required this.onChanged,
  }) : super(key: key);
  @override
  State<InputPasswordField> createState() => _InputPasswordFieldState();
}

class _InputPasswordFieldState extends State<InputPasswordField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 15),
        child: Container(
            child: TextFormField(
              obscureText: !isVisible,
              onChanged: widget.onChanged,
              cursorColor:
                  context.watch<ThemeProvider>().getSecondaryFontColor(),
              style: GoogleFonts.poppins(
                decoration: TextDecoration.none,
                decorationThickness: 0,
                decorationColor: context
                    .watch<ThemeProvider>()
                    .getBackgroundColor()
                    .withOpacity(0.0),
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: context.watch<ThemeProvider>().getSecondaryFontColor(),
              ),
              decoration: InputDecoration(
                labelText: widget.text,
                labelStyle: kPrimartFont(
                    context.watch<ThemeProvider>().getSecondaryFontColor(),
                    16,
                    FontWeight.normal),
                prefixIcon: Icon(
                  Icons.lock,
                  color: context.watch<ThemeProvider>().getSecondaryFontColor(),
                ),
                suffixIcon: InkWell(
                  onTap: () => setState(() {
                    isVisible = !isVisible;
                  }),
                  child: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                    color:
                        context.watch<ThemeProvider>().getSecondaryFontColor(),
                  ),
                ),
                border: InputBorder.none,
              ),
            ),
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
                ])));
  }
}
