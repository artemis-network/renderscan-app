import 'package:flutter/material.dart';

class ThemeColors {
  Color backgroundColor = Color(0xff1e003c);
  Color foregroundColor = Colors.grey.shade400;

  Color primaryFontColor = Colors.white;
  Color secondaryFontColor = Colors.blueGrey.shade200;
  Color highLightColor = Color(0xff9900ff);
  Color favouriteColor = Color(0xff00ff99);
  Color navbarColor = Colors.black;
  Color navbarIconColor = Colors.white;

  ThemeColors(
      {required this.backgroundColor,
      required this.foregroundColor,
      required this.primaryFontColor,
      required this.secondaryFontColor,
      required this.highLightColor,
      required this.navbarIconColor,
      required this.favouriteColor,
      required this.navbarColor});
}

class ThemeProvider extends ChangeNotifier {
  ThemeColors? theme = new ThemeColors(
      backgroundColor: Color(0xff1e003c),
      foregroundColor: Colors.grey.shade400,
      primaryFontColor: Colors.white,
      secondaryFontColor: Colors.blueGrey.shade200,
      highLightColor: Color(0xff9900ff),
      favouriteColor: Color(0xff00ff99),
      navbarColor: Colors.black,
      navbarIconColor: Colors.white);

  bool _isDark = true;

  setTheme(bool isDark) {
    _isDark = isDark;
    if (!isDark) {
      ThemeColors light = ThemeColors(
          backgroundColor: Color(0xffeaeaea),
          foregroundColor: Colors.blueGrey,
          primaryFontColor: Colors.black,
          secondaryFontColor: Colors.blueGrey.shade900,
          highLightColor: Color(0xff9900ff),
          favouriteColor: Color(0xff00ff99),
          navbarColor: Colors.white,
          navbarIconColor: Colors.black);
      this.theme = light;
    } else {
      ThemeColors dark = ThemeColors(
          backgroundColor: Color(0xff1e003c),
          foregroundColor: Colors.grey.shade400,
          primaryFontColor: Colors.white,
          secondaryFontColor: Colors.blueGrey.shade200,
          highLightColor: Color(0xff9900ff),
          favouriteColor: Color(0xff00ff99),
          navbarIconColor: Colors.black,
          navbarColor: Colors.white);
      this.theme = dark;
    }
    notifyListeners();
  }

  getBackgroundColor() => theme?.backgroundColor ?? Colors.white;
  getForegroundColor() => theme?.foregroundColor ?? Colors.white;
  getPriamryFontColor() => theme?.primaryFontColor ?? Colors.white;
  getSecondaryFontColor() => theme?.secondaryFontColor ?? Colors.white;
  getHighLightColor() => theme?.highLightColor ?? Colors.white;
  getFavouriteColor() => theme?.favouriteColor ?? Colors.white;

  getNavbarColor() => theme?.navbarColor ?? Colors.white;
  getNavbarIconColor() => theme?.navbarIconColor ?? Colors.white;
  isDarkTheme() => _isDark;
}
