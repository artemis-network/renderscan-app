import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/theme/theme_provider.dart';

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
        width: size.width * 0.75,
        decoration: BoxDecoration(
            color: context.watch<ThemeProvider>().getHighLightColor(),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 100,
                  color: context
                      .watch<ThemeProvider>()
                      .getPriamryFontColor()
                      .withOpacity(0.22),
                  offset: Offset(0, 0)),
            ]),
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: kPrimartFont(Colors.white, 18, FontWeight.bold),
        ),
      ),
    );
  }
}
