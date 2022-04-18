import 'dart:developer';

import 'package:flutter/material.dart';

// components
import 'package:renderscan/common/components/rounded_button.dart';
import 'package:renderscan/common/components/rounded_input.dart';
import 'package:renderscan/common/components/already_have_account.dart';
import 'package:renderscan/screen/login/login_dtos.dart';

// screens
import 'package:renderscan/screen/signup/signup_screen.dart';
import 'package:renderscan/screen/home/home_screen.dart';

// api
import 'package:renderscan/screen/login/log_api.dart';

// logger
import 'package:renderscan/common/utils/logger.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = false;
  String username = "";
  String password = "";
  bool error = false;
  String message = "";

  void handleEmailInput(String _username) {
    setState(() {
      username = _username;
    });
  }

  void handlePasswordInput(String _password) {
    setState(() {
      password = _password;
    });
  }

  void handleSuccess(LoginResponse response) {
    print(response);
    setState(() {
      error = response.error!;
      message = response.message!;
    });
    if (!error) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        ),
      );
    }
  }

  void authenticate() {
    LoginRequest request = LoginRequest(username: username, password: password);
    Future<LoginResponse> response = LoginApi().authenticateUser(request);
    response
        .then((resp) => handleSuccess(resp))
        .catchError((err) => log.d(err));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              Image.asset(
                "assets/images/login.png",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (email) => handleEmailInput(email),
              ),
              RoundedPasswordField(
                onChanged: (password) => handlePasswordInput(password),
              ),
              RoundedButton(
                text: "LOGIN",
                press: authenticate,
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const SignUpScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.white,
  primary: Colors.purple[700],
  minimumSize: const Size(240, 50),
  textStyle: const TextStyle(color: Colors.white, fontSize: 24),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  elevation: 10,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
);

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: -100,
            left: -100,
            child: Image.asset(
              "assets/images/gradient_one.png",
              width: size.width * 0.55,
            ),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: Image.asset(
              "assets/images/gradient_two.png",
              width: size.width * 0.6,
            ),
          ),
          child,
        ],
      ),
    );
  }
}