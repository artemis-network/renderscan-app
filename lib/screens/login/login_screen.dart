import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/utils/storage.dart';
import 'package:renderscan/theme/theme_provider.dart';

import 'package:renderscan/screens/signup/signup_screen.dart';
import 'package:renderscan/screens/navigation/navigation_screen.dart';
import 'package:renderscan/screens/forgot_password/forgot_password_screen.dart';

import 'package:page_transition/page_transition.dart';
import 'package:renderscan/common/components/loader.dart';
import 'package:renderscan/common/components/exit_dialog.dart';

import 'package:renderscan/screens/login/log_api.dart';
import 'package:renderscan/screens/login/login_model.dart';
import 'package:renderscan/screens/login/components/input_field.dart';
import 'package:renderscan/screens/login/components/login_button.dart';
import 'package:renderscan/screens/login/components/google_login_button.dart';
import 'package:renderscan/screens/login/components/input_password_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
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

  setIsLoading(bool _isLoading) {
    setState(() {
      isLoading = _isLoading;
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

  GlobalKey<FormState> formkey = GlobalKey<FormState>(debugLabel: "login");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void handleError(String argMessage, bool argError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: argError ? Colors.redAccent : Colors.greenAccent,
          content: Text(
            argMessage,
            style: kPrimartFont(Colors.black, 14, FontWeight.bold),
          )));
    }

    void handleSuccess(AuthResponse response) {
      setState(() {
        isLoading = false;
        error = response.error ?? true;
        message = response.message ?? "Some thing went wrong";
      });
      if (!error) {
        Storage().createSession(response);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const NavigationScreen();
            },
          ),
        );
      } else {
        handleError("Internal Serveer Error", false);
      }
    }

    void authenticate() {
      if (username != "" && password != "") {
        setIsLoading(true);
        AuthRequest request =
            AuthRequest(username: username, password: password);
        Future<AuthResponse> response = LoginApi().authenticateUser(request);
        response.then((resp) {
          setIsLoading(false);
          handleSuccess(resp);
        }).catchError((err) {
          handleError(err, true);
          setIsLoading(false);
        });
      } else {
        handleError("Enter Credentails", true);
      }
    }

    var scaffoldKey = GlobalKey<ScaffoldState>();

    return new AppExitDialogWrapper(
      child: Scaffold(
        body: Container(
          color: context.watch<ThemeProvider>().getBackgroundColor(),
          padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
          child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.cancel_outlined,
                          size: 42,
                          color: context
                              .watch<ThemeProvider>()
                              .getPriamryFontColor(),
                        )),
                  ),
                  Image.asset(
                    "assets/images/no_bg_logo.png",
                    height: size.height * 0.2,
                  ),
                  InputField(
                    icon: Icons.email,
                    labelText: "Email",
                    onChange: (email) => handleEmailInput(email),
                  ),
                  InputPasswordField(
                    text: "Password",
                    onChanged: (password) => handlePasswordInput(password),
                  ),
                  TextButton(
                    onPressed: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageTransition(
                                type: PageTransitionType.leftToRight,
                                child: ForgotPassword(),
                                ctx: context,
                                duration: Duration(milliseconds: 300),
                                fullscreenDialog: true,
                                childCurrent: LoginScreen()));
                          },
                          child: Text(
                            "forgot Password ?",
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
                  !isLoading
                      ? LoginButton(
                          text: "LOGIN",
                          press: authenticate,
                        )
                      : spinkit(),
                  GoogleLoginButton(),
                  TextButton(
                    onPressed: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontSize: 16,
                            color: context
                                .watch<ThemeProvider>()
                                .getSecondaryFontColor(),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageTransition(
                                type: PageTransitionType.leftToRight,
                                child: SignUpScreen(),
                                ctx: context,
                                duration: Duration(milliseconds: 300),
                                fullscreenDialog: true,
                                childCurrent: LoginScreen()));
                          },
                          child: Text(
                            " Sign Up",
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
              )),
        ),
      ),
    );
  }
}
