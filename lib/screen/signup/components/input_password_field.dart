import 'package:flutter/material.dart';
import 'package:renderscan/constants.dart';

class InputPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String text;
  final Function validation;

  const InputPasswordField(
      {Key? key,
      required this.text,
      required this.onChanged,
      required this.validation})
      : super(key: key);
  @override
  State<InputPasswordField> createState() => _InputPasswordFieldState();
}

class _InputPasswordFieldState extends State<InputPasswordField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 15),
        child: Container(
            child: TextFormField(
              obscureText: isVisible,
              validator: (value) => widget.validation(value),
              onChanged: widget.onChanged,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: widget.text,
                labelText: widget.text,
                labelStyle:
                    kPrimartFont(kPrimaryLightColor, 16, FontWeight.normal),
                prefixIcon: Icon(
                  Icons.lock,
                  color: kPrimaryLightColor,
                ),
                suffixIcon: InkWell(
                  onTap: () => setState(() {
                    isVisible = !isVisible;
                  }),
                  child: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                    color: kPrimaryLightColor,
                  ),
                ),
                border: InputBorder.none,
              ),
            ),
            decoration: BoxDecoration(
                color: Color(0xff3A0E81),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: -5,
                      blurRadius: 8,
                      color: Color(0xff080212),
                      offset: Offset(-5, -5)),
                  BoxShadow(
                    spreadRadius: -2,
                    blurRadius: 4,
                    color: Color(0xff6418DC),
                  )
                ])));
  }
}