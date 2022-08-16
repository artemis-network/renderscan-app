import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/theme/theme_provider.dart';

class ExploreSearchInput extends StatelessWidget {
  final Function onChange;
  final String label;

  ExploreSearchInput({required this.onChange, required this.label});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return TextFormField(
      onChanged: (e) => onChange(e),
      style: kPrimartFont(context.watch<ThemeProvider>().getForegroundColor(),
          16, FontWeight.normal),
      cursorColor: context.watch<ThemeProvider>().getForegroundColor(),
      decoration: InputDecoration(
        constraints: BoxConstraints(maxWidth: size.width * 0.75),
        focusColor: context.watch<ThemeProvider>().getForegroundColor(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: context.watch<ThemeProvider>().getHighLightColor()),
            borderRadius: BorderRadius.circular(20)),
        hintText: label,
        hintStyle: kPrimartFont(
            context.watch<ThemeProvider>().getForegroundColor(),
            18,
            FontWeight.bold),
      ),
    );
  }
}
