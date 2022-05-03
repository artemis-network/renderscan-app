import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:renderscan/constants.dart';

class InputField extends StatelessWidget {
  final bool hasError;
  final String errorMessage;
  final String labelText;
  final IconData icon;
  final Function onChange;
  final bool isHidden;

  InputField(
      {Key? key,
      required this.isHidden,
      required this.hasError,
      required this.errorMessage,
      required this.labelText,
      required this.icon,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    back() => Navigator.of(context).pop();
    showErrorDialog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              backgroundColor: kprimaryAuthBGColor,
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Text(
                        errorMessage,
                        style:
                            kPrimartFont(Colors.redAccent, 16, FontWeight.bold),
                      ),
                      OutlinedButton(
                        onPressed: back,
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: BorderSide(color: Colors.white))),
                        ),
                        child: Text("Okay",
                            style: kPrimartFont(
                                kPrimaryLightColor, 18, FontWeight.bold)),
                      )
                    ],
                  ),
                ),
              ],
            );
          });
    }

    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        decoration: BoxDecoration(
            color: kprimaryAuthNeuFGColor,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                  spreadRadius: -5,
                  blurRadius: 8,
                  color: kprimaryAuthNeuDarkColor,
                  offset: Offset(-5, -5)),
              BoxShadow(
                  spreadRadius: -2,
                  blurRadius: 4,
                  color: kprimaryAuthNeuLightColor,
                  offset: Offset(1, 1)),
            ]),
        child: TextField(
          obscureText: isHidden,
          onChanged: (value) => onChange(value),
          cursorColor: kPrimaryLightColor,
          style: GoogleFonts.poppins(
              decoration: TextDecoration.none,
              decorationThickness: 0,
              decorationColor: kprimaryAuthNeuFGColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: kPrimaryLightColor),
          decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: kPrimaryLightColor,
              ),
              suffixIcon: hasError
                  ? GestureDetector(
                      onTap: showErrorDialog,
                      child: Icon(Icons.info, color: Colors.redAccent),
                    )
                  : Icon(Icons.check_circle, color: Colors.greenAccent),
              label: Text(
                labelText,
                style: kPrimartFont(kPrimaryLightColor, 15, FontWeight.normal),
                maxLines: 1,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15)),
        ),
      ),
    );
  }
}
