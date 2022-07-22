import 'package:flutter/material.dart';

class ThemeColors {
  Color backgroundColor = Colors.white;
  Color foregroundColor = Colors.grey.shade400;
  Color primaryFontColor = Colors.black;
  Color secondaryFontColor = Colors.blueGrey.shade700;
  Color highLightColor = Colors.blueAccent.shade400;
  Color favouriteColor = Colors.redAccent.shade400;

  ThemeColors(
      {required this.backgroundColor,
      required this.foregroundColor,
      required this.primaryFontColor,
      required this.secondaryFontColor,
      required this.highLightColor,
      required this.favouriteColor});
}

class ThemeProvider extends ChangeNotifier {
  ThemeColors? theme = new ThemeColors(
      backgroundColor: Colors.black,
      foregroundColor: Colors.grey.shade400,
      primaryFontColor: Colors.white,
      secondaryFontColor: Colors.blueGrey.shade200,
      highLightColor: Colors.blueAccent.shade400,
      favouriteColor: Colors.redAccent.shade400);

  bool _isDark = true;

  setTheme(bool isDark) {
    _isDark = isDark;
    if (!isDark) {
      ThemeColors light = ThemeColors(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blueGrey,
          primaryFontColor: Colors.black,
          secondaryFontColor: Colors.blueGrey.shade900,
          highLightColor: Colors.blueAccent.shade400,
          favouriteColor: Colors.redAccent.shade400);
      this.theme = light;
    } else {
      ThemeColors dark = ThemeColors(
          backgroundColor: Colors.black,
          foregroundColor: Colors.grey.shade400,
          primaryFontColor: Colors.white,
          secondaryFontColor: Colors.blueGrey.shade200,
          highLightColor: Colors.blueAccent.shade400,
          favouriteColor: Colors.redAccent.shade400);
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
  isDarkTheme() => _isDark;
}
