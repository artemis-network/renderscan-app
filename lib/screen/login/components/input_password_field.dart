import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:renderscan/constants.dart';

class InputPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String text;
  final isPasswordVisible;

  const InputPasswordField({
    Key? key,
    required this.text,
    required this.onChanged,
    this.isPasswordVisible,
  }) : super(key: key);
  @override
  State<InputPasswordField> createState() => _InputPasswordFieldState();
}

class _InputPasswordFieldState extends State<InputPasswordField> {
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 15),
        child: Container(
            child: TextFormField(
              obscureText: isPasswordHidden,
              onChanged: widget.onChanged,
              cursorColor: kPrimaryLightColor,
              style: GoogleFonts.poppins(
                  decoration: TextDecoration.none,
                  decorationThickness: 0,
                  decorationColor: kprimaryAuthNeuFGColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: kPrimaryLightColor),
              decoration: InputDecoration(
                labelText: widget.text,
                labelStyle:
                    kPrimartFont(kPrimaryLightColor, 16, FontWeight.normal),
                prefixIcon: Icon(
                  Icons.lock,
                  color: kPrimaryLightColor,
                ),
                suffixIcon: InkWell(
                  onTap: () => setState(() {
                    isPasswordHidden = !isPasswordHidden;
                  }),
                  child: Icon(
                    !isPasswordHidden ? Icons.visibility : Icons.visibility_off,
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
