import 'package:flutter/material.dart';
import 'package:renderscan/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          labelText: hintText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
