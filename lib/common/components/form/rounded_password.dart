import 'package:flutter/material.dart';
import 'package:renderscan/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String text;
  final Function validation;

  const RoundedPasswordField(
      {Key? key,
      required this.text,
      required this.onChanged,
      required this.validation})
      : super(key: key);
  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 15),
        child: TextFormField(
          obscureText: isVisible,
          validator: (value) => widget.validation(value),
          onChanged: widget.onChanged,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            hintText: widget.text,
            labelText: widget.text,
            prefixIcon: Icon(
              Icons.lock,
              color: kPrimaryColor,
            ),
            suffixIcon: InkWell(
              onTap: () => setState(() {
                isVisible = !isVisible;
              }),
              child: Icon(
                isVisible ? Icons.visibility : Icons.visibility_off,
                color: kPrimaryColor,
              ),
            ),
            border: OutlineInputBorder(),
          ),
        ));
  }
}
