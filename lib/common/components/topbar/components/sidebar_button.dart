import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/theme/theme_provider.dart';

class SideBarButton extends StatefulWidget {
  final String text;
  final String icon;
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
            child: Row(
              children: <Widget>[
                Image.asset(
                  widget.icon,
                  height: 40,
                  width: 40,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  widget.text,
                  style: kPrimartFont(
                      context.watch<ThemeProvider>().getPriamryFontColor(),
                      16,
                      FontWeight.bold),
                )
              ],
            ),
          )),
    );
  }
}
