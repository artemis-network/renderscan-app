import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';

class WalletRoundedButton extends StatefulWidget {
  final IconData icon;
  final String text;
  final VoidCallback callback;

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
        child: AnimatedContainer(
      duration: Duration(milliseconds: 250),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: context.watch<ThemeProvider>().getBackgroundColor(),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 100,
                      color: context
                          .watch<ThemeProvider>()
                          .getHighLightColor()
                          .withOpacity(0.33),
                      offset: Offset(0, 0)),
                ]),
            child: Icon(
              widget.icon,
              color: context.watch<ThemeProvider>().getHighLightColor(),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(widget.text,
              style: kPrimartFont(
                  context.watch<ThemeProvider>().getPriamryFontColor(),
                  12,
                  FontWeight.normal))
        ],
      ),
    ));
  }
}
