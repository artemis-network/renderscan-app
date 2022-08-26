import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'package:renderscan/screens/login/log_api.dart';
import 'package:renderscan/screens/navigation/navigation_screen.dart';
import 'package:renderscan/theme/theme_provider.dart';
import 'package:renderscan/utils/logger.dart';
import 'package:renderscan/utils/storage.dart';

class GoogleLoginButton extends StatefulWidget {
  @override
  State<GoogleLoginButton> createState() => _GoogleLoginButtonState();
}

class _GoogleLoginButtonState extends State<GoogleLoginButton> {
  @override
  Widget build(BuildContext context) {
    bool _isElevated = true;
    GoogleSignIn _googleSignin = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.2, 0, size.width * 0.2, 0),
      child: GestureDetector(
        child: AnimatedContainer(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: context.watch<ThemeProvider>().getBackgroundColor(),
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 0,
                    blurRadius: 1,
                    color: context.watch<ThemeProvider>().getFavouriteColor(),
                    offset: Offset(0, 0)),
              ]),
          duration: Duration(milliseconds: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/google-plus.png",
                height: 26,
                width: 26,
              ),
              Image.asset(
                "assets/images/google.png",
                height: 42,
                width: 70,
              )
            ],
          ),
        ),
        onTapUp: (tu) {
          setState(() {
            _isElevated = !_isElevated;
          });
        },
        onTapDown: (td) {
          setState(() {
            _isElevated = !_isElevated;
          });

          _googleSignin.signIn().then((user) {
            user = user as GoogleSignInAccount;
            LoginApi().googleLogin(user.email).then((value) {
              bool error = value.error ?? false;
              if (!error) {
                Storage().createSession(value);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return NavigationScreen();
                    },
                  ),
                );
              }
            }).catchError((err) {
              log.e(err);
            });
          }).catchError((err) {
            log.e(err);
          });
        },
      ),
    );
  }
}
