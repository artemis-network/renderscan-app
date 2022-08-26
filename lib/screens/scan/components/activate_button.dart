import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/theme/theme_provider.dart';

class ActivateButton extends StatefulWidget {
  final String text;
  final Function press;
  const ActivateButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  State<ActivateButton> createState() => _ActivateButtonState();
}

class _ActivateButtonState extends State<ActivateButton> {
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
        duration: Duration(microseconds: 250),
        padding: EdgeInsets.all(20),
        width: size.width * 0.6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _isElevated
                ? context.watch<ThemeProvider>().getHighLightColor()
                : context.watch<ThemeProvider>().getFavouriteColor(),
            boxShadow: [
              BoxShadow(
                  blurRadius: 1,
                  color: context.watch<ThemeProvider>().getHighLightColor())
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
