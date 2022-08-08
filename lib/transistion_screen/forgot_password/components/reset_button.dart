import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';

class ResetButton extends StatefulWidget {
  final String text;
  final Function press;
  const ResetButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  State<ResetButton> createState() => _ResetButtonState();
}

class _ResetButtonState extends State<ResetButton> {
  bool _isElevated = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTapUp: (tu) {
        setState(() {
          _isElevated = !_isElevated;
        });
      },
      onTapDown: (td) {
        setState(() {
          _isElevated = !_isElevated;
        });
        widget.press();
      },
      child: AnimatedContainer(
        margin: EdgeInsets.all(10),
        duration: Duration(milliseconds: 100),
        padding: EdgeInsets.all(20),
        width: size.width * 0.6,
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
            ]),
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: kPrimartFont(
              context.watch<ThemeProvider>().getSecondaryFontColor(),
              18,
              FontWeight.bold),
        ),
      ),
    );
  }
}
