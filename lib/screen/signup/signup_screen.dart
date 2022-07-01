import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/exit_dialog.dart';
import 'package:renderscan/common/components/loader.dart';
import 'package:renderscan/common/theme/theme_provider.dart';
import 'package:renderscan/common/utils/logger.dart';

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
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String confirmPassword = "";

  String username = "";
  String usernameError = "Username Required";
  bool isUsernameHasError = true;

  String email = "";
  String emailError = "Email Required";
  bool isEmailHasError = true;

  String password = "";
  String passwordError = "Password Required";
  bool isPasswordHasError = true;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    redirectToLogin() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        ),
      );
    }

    void handleUsername(String _username) {
      String error = SignupValidations().usernameValidations(_username)!;
      if (error == "") {
        setState(() {
          isUsernameHasError = false;
        });
      } else {
        setState(() {
          isUsernameHasError = true;
        });
      }
      setState(() {
        username = _username;
        usernameError = error;
      });
    }

    void handleEmail(String _email) {
      String error = SignupValidations().emailValidations(_email)!;
      if (error == "") {
        setState(() {
          isEmailHasError = false;
        });
      } else {
        setState(() {
          isEmailHasError = true;
        });
      }
      setState(() {
        email = _email;
        emailError = error;
      });
    }

    void handlePassword(String _password) {
      String error = SignupValidations().passwordValidation(_password)!;
      if (error == "") {
        setState(() {
          isPasswordHasError = false;
        });
      } else {
        setState(() {
          isPasswordHasError = true;
        });
      }
      setState(() {
        password = _password;
        passwordError = error;
      });
    }

    void handleConfirmPassword(String _confirmPassword) {
      setState(() {
        confirmPassword = _confirmPassword;
      });
      if (password != _confirmPassword) {
        setState(() {
          isPasswordHasError = true;
          passwordError = "*Passwords wont match";
        });
      } else {
        setState(() {
          isPasswordHasError = false;
          passwordError = "";
        });
      }
    }

    handleRequest(SignUpResponse response) {
      setState(() {
        _isLoading = false;
      });
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
          duration: const Duration(milliseconds: 5000),
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
      var future =
          Future.delayed(const Duration(seconds: 1), () => redirectToLogin());
      future.then((value) => null).catchError((err) {
        log.e(err);
      });
    }

    return AppExitDialogWrapper(
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
                        isHidden: false,
                        hasError: isUsernameHasError,
                        errorMessage: usernameError,
                        icon: Icons.person_add_alt_1,
                        labelText: "Username",
                        onChange: (value) => handleUsername(value),
                      ),
                      InputField(
                        isHidden: false,
                        hasError: isEmailHasError,
                        errorMessage: emailError,
                        icon: Icons.email,
                        labelText: "Email",
                        onChange: (value) => handleEmail(value),
                      ),
                      InputField(
                        isHidden: true,
                        hasError: isPasswordHasError,
                        errorMessage: passwordError,
                        icon: Icons.lock,
                        labelText: "password",
                        onChange: (value) => handlePassword(value),
                      ),
                      InputPasswordField(
                        text: "Confirm Password",
                        onChanged: (value) => handleConfirmPassword(value),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      _isLoading
                          ? spinkit
                          : SignUpButton(
                              text: "Sign Up",
                              press: () {
                                bool isValid = !isUsernameHasError &&
                                    !isEmailHasError &&
                                    !isPasswordHasError &&
                                    password.isNotEmpty;

                                log.i(">> LOG :" + isValid.toString());
                                if (isValid) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  SignUpRequest signUpRequest =
                                      new SignUpRequest(
                                    username: username.trim(),
                                    email: email.trim(),
                                    password: password.trim(),
                                  );
                                  SignUpApi()
                                      .registerUser(signUpRequest)
                                      .then((value) => handleRequest(value));
                                } else {
                                  Color bgColor = Colors.red;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      action: SnackBarAction(
                                        label: "Close",
                                        onPressed: () {},
                                      ),
                                      backgroundColor: bgColor,
                                      content: Text("Invalid credentails"),
                                      duration:
                                          const Duration(milliseconds: 3000),
                                      width: size.width *
                                          0.9, // Width of the SnackBar.
                                      padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            24.0, // Inner padding for SnackBar content.
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  );
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                fontSize: 16,
                                color: context
                                    .watch<ThemeProvider>()
                                    .getSecondaryFontColor(),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Container(
                              child: Text(
                                " Sign In",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: context
                                      .watch<ThemeProvider>()
                                      .getSecondaryFontColor(),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
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
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Container(
        color: context.watch<ThemeProvider>().getBackgroundColor(),
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
      ),
    );
  }
}
