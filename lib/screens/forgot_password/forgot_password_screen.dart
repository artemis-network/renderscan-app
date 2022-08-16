import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/forgot_password/components/reset_button.dart';
import 'package:renderscan/screens/forgot_password/forgot_password_api.dart';
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
    return SafeArea(
        child: Scaffold(
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 45),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter your email",
                textAlign: TextAlign.center,
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getHighLightColor(),
                    24,
                    FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              InputField(
                icon: Icons.email,
                labelText: "Email",
                onChange: (email) => handleEmailInput(email),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Text(
                  "password reset link will be sent to your mail",
                  textAlign: TextAlign.center,
                  style: kPrimartFont(
                      context.watch<ThemeProvider>().getHighLightColor(),
                      18,
                      FontWeight.normal),
                ),
              ),
              Text(
                "password reset link will be sent to your mail",
                textAlign: TextAlign.center,
                style: kPrimartFont(
                    context.watch<ThemeProvider>().getHighLightColor(),
                    18,
                    FontWeight.normal),
              ),
              SizedBox(
                height: 50,
              ),
              ResetButton(
                  text: "Reset Password",
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
            ]),
      ),
    ));
  }
}
