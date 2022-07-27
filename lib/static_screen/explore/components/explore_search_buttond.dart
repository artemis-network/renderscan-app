import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';

class ExploreSearchButton extends StatelessWidget {
  final bool submit;
  final Function search;
  final Function cancel;
  ExploreSearchButton(
      {required this.submit, required this.cancel, required this.search});

  @override
  Widget build(BuildContext context) {
    return !submit
        ? Container(
            child: IconButton(
                color: context.watch<ThemeProvider>().getHighLightColor(),
                icon: Icon(
                  Icons.search,
                  color: context.watch<ThemeProvider>().getPriamryFontColor(),
                  size: 30,
                ),
                onPressed: () => search()))
        : Container(
            child: IconButton(
                color: context.watch<ThemeProvider>().getHighLightColor(),
                icon: Icon(
                  Icons.cancel,
                  color: context.watch<ThemeProvider>().getPriamryFontColor(),
                  size: 30,
                ),
                onPressed: () => cancel()));
  }
}
