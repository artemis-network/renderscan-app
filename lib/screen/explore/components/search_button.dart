import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';

class SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: kPrimartFont(context.watch<ThemeProvider>().getForegroundColor(),
          16, FontWeight.normal),
      cursorColor: context.watch<ThemeProvider>().getForegroundColor(),
      decoration: InputDecoration(
          focusColor: context.watch<ThemeProvider>().getForegroundColor(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: context.watch<ThemeProvider>().getHighLightColor()),
              borderRadius: BorderRadius.circular(20)),
          hintText: "Search",
          hintStyle: kPrimartFont(
              context.watch<ThemeProvider>().getForegroundColor(),
              18,
              FontWeight.bold),
          suffixIcon: Icon(Icons.clear_outlined,
              color: context.watch<ThemeProvider>().getPriamryFontColor()),
          prefixIcon: Icon(Icons.search_rounded,
              color: context.watch<ThemeProvider>().getPriamryFontColor())),
    );
  }
}
