import 'package:flutter/material.dart';

import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';

class SideBarButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final Function onClick;

  SideBarButton(
      {Key? key, required this.text, required this.icon, required this.onClick})
      : super(key: key);

  @override
  State<SideBarButton> createState() => _SideBarButtonState();
}

class _SideBarButtonState extends State<SideBarButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () => widget.onClick(),
      child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
          child: Container(
              width: size.width,
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
              child: Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        widget.icon,
                        size: 24,
                        color: context
                            .watch<ThemeProvider>()
                            .getPriamryFontColor(),
                      )),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.text,
                        style: kPrimartFont(
                            context
                                .watch<ThemeProvider>()
                                .getPriamryFontColor(),
                            14,
                            FontWeight.normal),
                      ))
                ],
              ),
              decoration: BoxDecoration(
                  color: context.watch<ThemeProvider>().getBackgroundColor(),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 0,
                        blurRadius: 100,
                        color: context
                            .watch<ThemeProvider>()
                            .getHighLightColor()
                            .withOpacity(0.22),
                        offset: Offset(0, 0)),
                  ]))),
    );
  }
}
