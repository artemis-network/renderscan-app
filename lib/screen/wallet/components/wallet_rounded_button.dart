import 'package:flutter/material.dart';
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
  bool _isElevated = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapUp: (tu) {
          setState(() {
            _isElevated = !_isElevated;
          });
        },
        onTapDown: (td) {
          setState(() {
            _isElevated = !_isElevated;
            widget.callback();
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: _isElevated
                        ? [
                            BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 2,
                                color: kprimaryNeuLight,
                                offset: Offset(-1, -1)),
                            BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 8,
                                color: kprimaryNeuDark,
                                offset: Offset(5, 5)),
                          ]
                        : [
                            BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 2,
                                color: kprimaryNeuLight,
                                offset: Offset(1, 1)),
                            BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 8,
                                color: kprimaryNeuDark,
                                offset: Offset(-5, -5)),
                          ]),
                child: Icon(
                  widget.icon,
                  color: kPrimaryLightColor,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(widget.text,
                  style:
                      kPrimartFont(kPrimaryLightColor, 12, FontWeight.normal))
            ],
          ),
        ));
  }
}
