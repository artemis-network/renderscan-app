import 'package:flutter/material.dart';
import 'package:renderscan/constants.dart';

class UpgradeButton extends StatefulWidget {
  final String text;

  const UpgradeButton({Key? key, required this.text}) : super(key: key);

  @override
  State<UpgradeButton> createState() => _UpgradeButtonState();
}

class _UpgradeButtonState extends State<UpgradeButton> {
  bool _isElevated = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pad = (size.width * 0.25);

    return GestureDetector(
      onTapDown: (td) {
        setState(() {
          _isElevated = !_isElevated;
        });
      },
      onTapUp: (td) {
        setState(() {
          _isElevated = !_isElevated;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        child: Padding(
            padding: EdgeInsets.fromLTRB(pad, 10, pad, 10),
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
              child: Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.text,
                        style: kPrimartFont(
                            kPrimaryLightColor, 14, FontWeight.bold),
                      ))
                ],
              ),
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
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
            )),
      ),
    );
  }
}
