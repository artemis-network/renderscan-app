import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';

class WalletRoundedButton extends StatefulWidget {
  final IconData icon;
  final String text;
  final Function callback;

  const WalletRoundedButton(
      {Key? key,
      required this.icon,
      required this.text,
      required this.callback})
      : super(key: key);

  @override
  State<WalletRoundedButton> createState() => _WalletRoundedButtonState();
}

class _WalletRoundedButtonState extends State<WalletRoundedButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => widget.callback(),
        child: AnimatedContainer(
          decoration: BoxDecoration(
              color: context.watch<ThemeProvider>().getBackgroundColor(),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 0,
                    blurRadius: 1,
                    color: context.watch<ThemeProvider>().getHighLightColor(),
                    offset: Offset(0, 0)),
              ]),
          alignment: Alignment.center,
          duration: Duration(milliseconds: 250),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Icon(
                  widget.icon,
                  size: 26,
                  color: context.watch<ThemeProvider>().getHighLightColor(),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(widget.text,
                  style: kPrimartFont(
                      context.watch<ThemeProvider>().getPriamryFontColor(),
                      28,
                      FontWeight.bold))
            ],
          ),
        ));
  }
}
