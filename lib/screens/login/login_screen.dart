import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:renderscan/constants.dart';
import 'package:renderscan/utils/logger.dart';
import 'package:renderscan/utils/storage.dart';
import 'package:renderscan/theme/theme_provider.dart';

import 'package:renderscan/screens/signup/signup_screen.dart';
import 'package:renderscan/screens/navigation/navigation_screen.dart';
import 'package:renderscan/screens/forgot_password/forgot_password_screen.dart';

import 'package:page_transition/page_transition.dart';
import 'package:renderscan/common/components/loader.dart';

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
            style: kPrimartFont(
                argError ? Colors.white : Colors.black, 14, FontWeight.bold),
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
              return NavigationScreen();
            },
          ),
        );
      } else {
        handleError(response.message.toString(), true);
      }
    }

    void authenticate() {
      if (username != "" && password != "") {
        setIsLoading(true);
        AuthRequest request =
            AuthRequest(username: username, password: password);
        Future<AuthResponse> response = LoginApi().authenticateUser(request);
        response.then((resp) {
          log.i(resp.message);
          log.i(resp.error);
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

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [],
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
        centerTitle: true,
        title: Text(
          "Login",
          style: kPrimartFont(
              context.watch<ThemeProvider>().getPriamryFontColor(),
              26,
              FontWeight.bold),
        ),
      ),
      backgroundColor: context.watch<ThemeProvider>().getBackgroundColor(),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
        child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "assets/images/no_bg_logo.png",
                    height: size.height * 0.2,
                  ),
                  InputField(
                    icon: Icons.email,
                    labelText: "Email/Username",
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
                            "Forgot Password ?",
                            style: TextStyle(
                              fontSize: 16,
                              color: context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  !isLoading
                      ? LoginButton(
                          text: "Login",
                          press: authenticate,
                        )
                      : spinkit(),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(alignment: Alignment.center, children: [
                    Positioned(
                        child: Container(
                      child: Divider(
                        height: 20,
                        thickness: 2,
                        color:
                            context.watch<ThemeProvider>().getFavouriteColor(),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 50),
                    )),
                    Positioned(
                        child: Container(
                      color:
                          context.watch<ThemeProvider>().getBackgroundColor(),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text("OR",
                          style: GoogleFonts.poppins(
                              color: context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                    )),
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  GoogleLoginButton(),
                  SizedBox(
                    height: 10,
                  ),
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
                                .getPriamryFontColor(),
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
                            " Register",
                            style: TextStyle(
                              fontSize: 16,
                              color: context
                                  .watch<ThemeProvider>()
                                  .getPriamryFontColor(),
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
    );
  }
}
