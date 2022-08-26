import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/loader.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/screens/login/components/input_password_field.dart';
import 'package:renderscan/screens/login/login_screen.dart';
import 'package:renderscan/screens/signup/components/input_field.dart';
import 'package:renderscan/screens/signup/components/signup_button.dart';
import 'package:renderscan/screens/signup/signup_api.dart';
import 'package:renderscan/screens/signup/signup_model.dart';
import 'package:renderscan/screens/signup/signup_validations.dart';
import 'package:renderscan/theme/theme_provider.dart';

// components

// pages

// signup api / models

// validations
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String confirmPassword = "";

  String referalCode = "";
  String username = "";
  String usernameError = "Username Required";
  bool isUsernameHasError = true;

  String name = "";
  String nameError = "Name Required";
  bool isNameHasError = true;

  String email = "";
  String emailError = "Email Required";
  bool isEmailHasError = true;

  String password = "";
  String passwordError = "Password Required";
  bool isPasswordHasError = true;

  bool _isLoading = false;

  late GlobalKey<FormState> formkey;

  @override
  void initState() {
    formkey = new GlobalKey<FormState>(debugLabel: "signup");
    super.initState();
  }

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

    void handleName(String _name) {
      String error = SignupValidations().nameValidations(_name)!;
      if (error == "") {
        setState(() {
          isNameHasError = false;
        });
      } else {
        setState(() {
          isNameHasError = true;
        });
      }
      setState(() {
        name = _name;
        nameError = error;
      });
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

    void handleReferalCode(String _referalCode) => setState(() {
          referalCode = _referalCode;
        });

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
      Color bgColor = hasError! ? Colors.redAccent : Colors.greenAccent;
      if (!hasError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: bgColor,
            content: Text(
              response.message ?? "Internal server error!",
              style: kPrimartFont(Colors.black, 14, FontWeight.bold),
            )));
        var future =
            Future.delayed(const Duration(seconds: 1), () => redirectToLogin());
        future.then((value) => null).catchError((err) {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: bgColor,
            content: Text(
              response.message ?? "Internal server error!",
              style: kPrimartFont(Colors.black, 14, FontWeight.bold),
            )));
      }
    }

    return Scaffold(
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            child: Image.asset(
              "assets/icons/back.png",
              height: 24,
              width: 24,
            ),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: context.watch<ThemeProvider>().getBackgroundColor(),
          padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
          child: Form(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Register",
                          style: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              color: context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor())),
                    ],
                  ),
                ),
                InputField(
                  isHidden: false,
                  hasError: isNameHasError,
                  errorMessage: nameError,
                  icon: Icons.person_add_alt_1,
                  labelText: "Name",
                  onChange: (value) => handleName(value),
                ),
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
                InputField(
                  isHidden: false,
                  hasError: false,
                  errorMessage: "",
                  icon: Icons.person_add_outlined,
                  labelText: "Referal Code",
                  onChange: (value) => handleReferalCode(value),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                _isLoading
                    ? spinkit()
                    : SignUpButton(
                        text: "Register",
                        press: () {
                          bool isValid = !isUsernameHasError &&
                              !isEmailHasError &&
                              !isPasswordHasError &&
                              password.isNotEmpty;

                          if (isValid) {
                            setState(() {
                              _isLoading = true;
                            });
                            SignUpRequest signUpRequest = new SignUpRequest(
                                name: name,
                                username: username.trim(),
                                email: email.trim(),
                                password: password.trim(),
                                referalCode: referalCode);
                            SignUpApi()
                                .registerUser(signUpRequest)
                                .then((value) => handleRequest(value));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.redAccent,
                                content: Text(
                                  "Invalid credentials",
                                  style: kPrimartFont(
                                      Colors.black, 14, FontWeight.bold),
                                )));
                          }
                        },
                      ),
                SizedBox(height: size.height * 0.03),
              ],
            ),
            key: formkey,
          ),
        ),
      ),
    );
  }
}
