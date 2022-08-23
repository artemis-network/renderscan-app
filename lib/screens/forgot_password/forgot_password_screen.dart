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
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [],
        iconTheme: IconThemeData(
            color: context.watch<ThemeProvider>().getPriamryFontColor(),
            size: 32),
        backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      ),
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              Container(
                child: Image.asset(
                  "assets/images/lion.png",
                  height: 220,
                  width: 220,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Forgot",
                      textAlign: TextAlign.left,
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getHighLightColor(),
                          24,
                          FontWeight.bold),
                    ),
                    Text(
                      "Password?",
                      textAlign: TextAlign.left,
                      style: kPrimartFont(
                          context.watch<ThemeProvider>().getHighLightColor(),
                          24,
                          FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                child: Text(
                  "password reset link will be sent to your mail",
                  textAlign: TextAlign.left,
                  style: kPrimartFont(
                      context.watch<ThemeProvider>().getHighLightColor(),
                      18,
                      FontWeight.normal),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30),
              ),
              InputField(
                icon: Icons.email,
                labelText: "Email",
                onChange: (email) => handleEmailInput(email),
              ),
              ResetButton(
                  text: "Submit",
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
      ),
    ));
  }
}
