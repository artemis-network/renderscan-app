import 'package:flutter/material.dart';
import 'package:renderscan/constants.dart';

class ProfileButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final Function onClick;

  ProfileButton(
      {Key? key, required this.text, required this.icon, required this.onClick})
      : super(key: key);

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
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
        widget.onClick();
      },
      child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
          child: Container(
              width: size.width,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        widget.icon,
                        color: kPrimaryLightColor,
                      )),
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
                        ]))),
    );
  }
}
