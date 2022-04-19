import 'package:flutter/material.dart';
import 'package:renderscan/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String text;
  const RoundedPasswordField(
      {Key? key, required this.text, required this.onChanged})
      : super(key: key);
  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isVisible,
      onChanged: widget.onChanged,
      cursorColor: kPrimaryColor,
      decoration: InputDecoration(
        hintText: widget.text,
        icon: const Icon(
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
        border: InputBorder.none,
      ),
    );
  }
}
