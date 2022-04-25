import 'package:flutter/material.dart';

// components
import 'package:renderscan/screen/signup/components/input_field.dart';
import 'package:renderscan/screen/signup/components/input_password_field.dart';
import 'package:renderscan/screen/signup/components/signup_button.dart';

// pages
import 'package:renderscan/screen/login/login_screen.dart';

// signup api / models
import 'package:renderscan/screen/signup/signup_api.dart';
import 'package:renderscan/screen/signup/signup_model.dart';

// validations
import 'package:renderscan/screen/signup/signup_validations.dart';

// global vars
import 'package:renderscan/constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String name = "";
  String email = "";
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    handleRequest(SignUpResponse response) {
      bool? hasError = response.hasError;
      Color bgColor = hasError! ? Colors.red : Colors.green;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          action: SnackBarAction(
            label: "Close",
            onPressed: () {},
          ),
          backgroundColor: bgColor,
          content: Text(response.message.toString()),
          duration: const Duration(milliseconds: 3000),
          width: size.width * 0.9, // Width of the SnackBar.
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0, // Inner padding for SnackBar content.
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    }

    return new WillPopScope(
        child: Scaffold(
          body: Background(
            child: SingleChildScrollView(
              child: Form(
                  key: formkey,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      children: <Widget>[
                        InputField(
                          icon: Icons.person,
                          labelText: "Name",
                          onChange: (value) => setState(() {
                            name = value;
                            email = email;
                            username = username;
                            password = password;
                          }),
                        ),
                        InputField(
                          icon: Icons.email,
                          labelText: "Email",
                          onChange: (value) => setState(() {
                            name = name;
                            email = value;
                            username = username;
                            password = password;
                          }),
                        ),
                        InputField(
                          icon: Icons.person_add_alt_1,
                          labelText: "Username",
                          onChange: (value) => setState(() {
                            name = name;
                            email = email;
                            username = value;
                            password = password;
                          }),
                        ),
                        InputPasswordField(
                          validation: SignupValidations().passwordValidation,
                          text: "Password",
                          onChanged: (value) => setState(() {
                            name = name;
                            email = email;
                            username = password;
                            password = value;
                          }),
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        SignUpButton(
                          text: "Sign Up",
                          press: () {
                            var isValid = formkey.currentState!.validate();
                            if (isValid) {
                              SignUpRequest signUpRequest = new SignUpRequest(
                                  email: email,
                                  name: name,
                                  password: password,
                                  username: username);
                              SignUpApi()
                                  .registerUser(signUpRequest)
                                  .then((value) => handleRequest(value));
                            }
                          },
                        ),
                        SizedBox(height: size.height * 0.03),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const LoginScreen();
                                },
                              ),
                            );
                          },
                          child: Text(
                            "Already have an account? Sign In",
                            style: TextStyle(
                              color: kPrimaryLightColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ),
        onWillPop: () async => false);
  }
}

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: kprimaryAuthBGColor,
      height: size.height,
      width: double.infinity,
      // Here i can use size.width but use double.infinity because both work as a same
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
              width: size.width * 0.5,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
