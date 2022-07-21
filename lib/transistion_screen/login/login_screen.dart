import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renderscan/common/components/exit_dialog.dart';
import 'package:renderscan/common/theme/theme_provider.dart';

// utils
import 'package:renderscan/common/utils/storage.dart';

//components
import 'package:renderscan/common/components/loader.dart';

// dto

// api

// logger
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/static_screen/navigation/navigation_screen.dart';
import 'package:renderscan/transistion_screen/login/components/google_login_button.dart';
import 'package:renderscan/transistion_screen/login/components/input_field.dart';
import 'package:renderscan/transistion_screen/login/components/input_password_field.dart';
import 'package:renderscan/transistion_screen/login/components/login_button.dart';
import 'package:renderscan/transistion_screen/login/log_api.dart';
import 'package:renderscan/transistion_screen/login/login_model.dart';
import 'package:renderscan/transistion_screen/signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void handleError(String? argMessage, bool? argError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          action: SnackBarAction(
            label: "Close",
            textColor: Colors.white,
            onPressed: () {
              setState(() {
                isPasswordVisible = false;
                username = "";
                password = "";
                error = argError ?? error;
                message = "";
              });
            },
          ),
          content: Text(argMessage ?? message),
          duration: const Duration(milliseconds: 3500),
          backgroundColor: argError ?? error ? Colors.red : Colors.green,
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
        handleError(null, null);
      }
    }

    void authenticate() {
      if (username != "" && password != "") {
        setIsLoading(true);
        AuthRequest request =
            AuthRequest(username: username, password: password);
        Future<AuthResponse> response = LoginApi().authenticateUser(request);
        response.then((resp) {
          log.i("> Handling Response");
          log.i("> Logged in username :" + resp.username.toString());
          setIsLoading(false);
          handleSuccess(resp);
        }).catchError((err) {
          log.e("> Handling Error :" + err);
          handleError(err, true);
          setIsLoading(false);
        });
      } else {
        handleError("Enter Credentails", true);
      }
    }

    var scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
        child: new AppExitDialogWrapper(
      child: Scaffold(
        key: scaffoldKey,
        drawer:
            Container(width: size.width, child: Drawer(child: SignUpScreen())),
        drawerEnableOpenDragGesture: false,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: Container(
          height: size.height,
          color: context.watch<ThemeProvider>().getBackgroundColor(),
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Form(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_outlined,
                          size: 30,
                          color: context
                              .watch<ThemeProvider>()
                              .getPriamryFontColor(),
                        )),
                  ),
                  Image.asset(
                    "assets/images/no_bg_logo.png",
                    height: size.height * 0.25,
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
                  SizedBox(height: size.height * 0.03),
                  !isLoading
                      ? LoginButton(
                          text: "LOGIN",
                          press: authenticate,
                        )
                      : spinkit,
                  SizedBox(height: size.height * 0.02),
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
                        Container(
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
                  SizedBox(height: size.height * 0.02),
                  GoogleLoginButton(),
                  SizedBox(
                    height: size.height * 0.1,
                  )
                ],
              ),
              key: formkey),
        )),
      ),
    ));
  }
}
