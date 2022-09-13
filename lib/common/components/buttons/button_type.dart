import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/theme/theme_provider.dart';

class ButtonType extends StatefulWidget {
  final String type;
  final String text;
  final Function press;
  const ButtonType({
    Key? key,
    required this.type,
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  State<ButtonType> createState() => _ButtonTypeState();
}

class _ButtonTypeState extends State<ButtonType> {
  bool buttonEffect = false;
  @override
  void initState() {
    setState(() {
      buttonEffect = false;
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    getType() {
      if (widget.type == "1") return TransitionType.CENTER_TB_OUT;
      if (widget.type == "2") return TransitionType.CENTER_LR_IN;
      if (widget.type == "3") return TransitionType.LEFT_TO_RIGHT;
      return TransitionType.CENTER_TB_OUT;
    }

    return AnimatedButton(
      onPress: () {
        setState(() {
          buttonEffect = true;
        });
        var future = Future.delayed(Duration(milliseconds: 500), () {
          widget.press();
          setState(() {
            buttonEffect = false;
          });
        });
        future.then((value) {});
      },
      width: 200,
      height: 60,
      text: widget.text,
      transitionType: getType(),
      borderRadius: 16,
      borderWidth: 4,
      borderColor: context.watch<ThemeProvider>().getHighLightColor(),
      isReverse: true,
      isSelected: buttonEffect,
      animationDuration: Duration(milliseconds: 500),
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      selectedTextColor: context.watch<ThemeProvider>().getPriamryFontColor(),
      selectedBackgroundColor:
          context.watch<ThemeProvider>().getHighLightColor(),
      textStyle: kPrimartFont(
          context.watch<ThemeProvider>().getPriamryFontColor(),
          18,
          FontWeight.bold),
    );
  }
}
