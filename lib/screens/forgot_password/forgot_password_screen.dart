import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/forgot_password/components/reset_button.dart';
import 'package:renderscan/screens/forgot_password/forgot_password_api.dart';
import 'package:renderscan/theme/theme_provider.dart';
import './components/input_field.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email = "";
  void handleEmailInput(String email) {
    setState(() {
      email = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            child: Image.asset(
              "assets/icons/cancel.png",
              height: 24,
              width: 24,
            ),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          ),
        ),
        backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      ),
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              child: Image.asset(
                "assets/icons/fp.png",
                height: 180,
                width: 180,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Forgot",
                    textAlign: TextAlign.center,
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        24,
                        FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Password?",
                    textAlign: TextAlign.center,
                    style: kPrimartFont(
                        context.watch<ThemeProvider>().getPriamryFontColor(),
                        24,
                        FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              child: Text(
                "Check your email and reset password",
                textAlign: TextAlign.center,
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getPriamryFontColor(),
                    18,
                    FontWeight.normal),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30),
            ),
            SizedBox(
              height: 25,
            ),
            InputField(
              icon: Icons.email,
              labelText: "Email",
              onChange: (email) => handleEmailInput(email),
            ),
            SizedBox(
              height: 35,
            ),
            ResetButton(
                text: "Send Email",
                press: () {
                  ForGotPasswordApi().sendForgotPasswordRequest(email).then(
                    (value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "password reset link has been sent to mail",
                              style: kPrimartFont(
                                  Colors.white, 14, FontWeight.bold))));
                    },
                  );
                })
          ])),
    );
  }
}
