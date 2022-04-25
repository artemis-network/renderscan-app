import 'package:flutter/material.dart';

// utils
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/constants.dart';

//components
import 'package:renderscan/screen/login/components/input_field.dart';
import 'package:renderscan/screen/login/components/input_password_field.dart';
import 'package:renderscan/screen/login/components/login_button.dart';

// dto
import 'package:renderscan/screen/login/login_model.dart';
import 'package:renderscan/screen/scan/scan_loader.dart';

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
  bool isLoading = false;
  bool isPasswordVisible = true;
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

  void togglePassword() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void handleSuccess(AuthResponse response) {
      setState(() {
        error = response.error!;
        message = response.message!;
      });
      if (!error) {
        Storage().createSession(response);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const HomeScreen();
            },
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            action: SnackBarAction(
              label: "Close",
              onPressed: () {
                setState(() {
                  isPasswordVisible = false;
                  username = "";
                  password = "";
                  error = false;
                  message = "";
                });
              },
            ),
            content: Text(message),
            duration: const Duration(milliseconds: 1500),
            backgroundColor: error ? Colors.red : Colors.green,
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
    }

    void authenticate() {
      AuthRequest request = AuthRequest(username: username, password: password);
      Future<AuthResponse> response = LoginApi().authenticateUser(request);
      setState(() {
        isLoading = true;
      });
      response.then((resp) {
        handleSuccess(resp);
        setState(() {
          isLoading = false;
        });
      }).catchError((err) => log.d(err));
    }

    if (isLoading)
      return Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: spinkit,
      );
    return new WillPopScope(
        child: Scaffold(
          body: Background(
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "assets/images/no_bg_logo.png",
                    height: size.height * 0.25,
                  ),
                  InputField(
                    icon: Icons.email,
                    labelText: "Email",
                    hintText: "Email",
                    onChange: (email) => handleEmailInput(email),
                  ),
                  isPasswordVisible
                      ? InputPasswordField(
                          validation: () => (null),
                          text: "Password",
                          onChanged: (password) =>
                              handlePasswordInput(password),
                        )
                      : InputField(
                          labelText: "",
                          hintText: "",
                          icon: Icons.lock,
                          onChange: (password) => handleEmailInput(password),
                        ),
                  SizedBox(height: size.height * 0.05),
                  LoginButton(
                    text: "LOGIN",
                    press: authenticate,
                  ),
                  SizedBox(height: size.height * 0.03),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SignUpScreen();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Create an account? Sign Up!",
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
        onWillPop: () async => false);
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
    return Container(
      color: kprimaryAuthBGColor,
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
