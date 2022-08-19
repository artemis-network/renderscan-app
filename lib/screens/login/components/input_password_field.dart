import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/theme/theme_provider.dart';

class InputPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String text;
  final isPasswordVisible;

  const InputPasswordField({
    Key? key,
    required this.text,
    required this.onChanged,
    this.isPasswordVisible,
  }) : super(key: key);
  @override
  State<InputPasswordField> createState() => _InputPasswordFieldState();
}

class _InputPasswordFieldState extends State<InputPasswordField> {
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 5),
        child: Container(
            child: TextFormField(
              obscureText: isPasswordHidden,
              onChanged: widget.onChanged,
              cursorColor:
                  context.watch<ThemeProvider>().getSecondaryFontColor(),
              style: GoogleFonts.poppins(
                  decoration: TextDecoration.none,
                  decorationThickness: 0,
                  decorationColor:
                      context.watch<ThemeProvider>().getSecondaryFontColor(),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color:
                      context.watch<ThemeProvider>().getSecondaryFontColor()),
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
                    isPasswordHidden = !isPasswordHidden;
                  }),
                  child: Icon(
                    !isPasswordHidden ? Icons.visibility : Icons.visibility_off,
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
                    offset: Offset(0, 0),
                    color: context
                        .watch<ThemeProvider>()
                        .getHighLightColor()
                        .withOpacity(0.22),
                  )
                ])));
  }
}
